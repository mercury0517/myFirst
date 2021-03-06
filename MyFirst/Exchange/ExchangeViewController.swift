import UIKit
import AudioToolbox
import MultipeerConnectivity // 通信を行う為に必要なモジュール

class ExchangeViewController: UIViewController {
    /*
     ユーザー識別用のID。
     画面に表示させることも出来るので、ユーザーネームとかを設定しておくと良い。
    */
    private let peerID: MCPeerID!
    
    /*
     サービス識別用の任意の文字列。
     info-plistには「_favorite._tcp」「_favorite._udp」を設定する(serviceTypeを記載する)
    */
    private let serviceType = "favorite"
    
    // 他の端末を探したり、招待を送る為に使用
    private var browser: MCNearbyServiceBrowser!
    
    // 他の端末から招待を受け取る為に使用
    private var advertiser: MCNearbyServiceAdvertiser!
    
    // 実際にデータの送受信を行う為に使用
    private var session: MCSession!
    
    let scrollView = UIScrollView()
    
    let statusLabel = UILabel()
    
    let hintButton = UIControl()
    let hintIcon = UIImageView(image: UIImage(named: "help"))
    
    let imageView = UIImageView(image: UIImage(named: "exchange"))

    let friendStackView = UIStackView()
    
    let buttonStackView = UIStackView()
    let hostButton = UIButton() // hostになる
    let guestButton = UIButton() // guestになる
    let sendFavoriteButton = UIButton()
    let disconnectButton = UIButton()
    
    let wifiDescriptionLabel = UILabel()
    let loadingDescriptionLabel = UILabel()
    
    var indicator = CustomIndicator()
    
    var recievedUniqueKey: String?
    var recievedFavoriteList: [MyFavorite] = []
    
    init() {
        if
            let data = UserDefaults.standard.object(forKey: UserDefaultKeys.userInfo) as? Data,
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo
        {
            self.peerID = MCPeerID.init(displayName: userInfo.name)
        } else {
            self.peerID = MCPeerID.init(displayName: "YOUR FRIEND")
        }
        
        // 通信に必要なオブジェクトの初期化
        self.browser = MCNearbyServiceBrowser(peer: self.peerID, serviceType: self.serviceType)
        self.advertiser = MCNearbyServiceAdvertiser(peer: self.peerID, discoveryInfo: nil, serviceType: self.serviceType)
        self.session = MCSession(peer: self.peerID)
        
        super.init(nibName: nil, bundle: nil)
        
        self.browser.delegate = self
        self.advertiser.delegate = self
        self.session.delegate = self
        
        self.navigationItem.title = "お気に入り交換"
    }
    
    required init?(coder: NSCoder) {
        self.peerID = MCPeerID.init(displayName: "unknown")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.friendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            self.statusLabel.text = "近くの友達とお気に入りを交換してみましょう"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 切断する時に全ての友達カードを消す
        DispatchQueue.main.async {
            self.friendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            self.indicator.stopAnimating()
        }

        // 他の画面に遷移したタイミングで、通信で使用していたものを全て止める
        self.session.disconnect()
        self.advertiser.stopAdvertisingPeer()
        self.browser.stopBrowsingForPeers()
        
        self.recievedUniqueKey = ""
        self.recievedFavoriteList = []
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.statusLabel)
        self.scrollView.addSubview(self.hintButton)
        self.hintButton.addSubview(self.hintIcon)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.friendStackView)
        self.scrollView.addSubview(self.buttonStackView)
        self.buttonStackView.addArrangedSubview(self.hostButton)
        self.buttonStackView.addArrangedSubview(self.guestButton)
        self.buttonStackView.addArrangedSubview(self.sendFavoriteButton)
        self.buttonStackView.addArrangedSubview(self.disconnectButton)
        self.scrollView.addSubview(self.wifiDescriptionLabel)
        self.scrollView.addSubview(self.loadingDescriptionLabel)
        self.view.addSubview(self.indicator)
    }
    
    private func configSubViews() {
        self.statusLabel.text = "近くの友達とお気に入りを交換しましょう！"
        self.statusLabel.numberOfLines = 2
        
        self.hintButton.addTarget(self, action: #selector(self.tappedHintButton), for: .touchUpInside)
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 10.0
        
        self.buttonStackView.alignment = .center
        self.buttonStackView.axis = .vertical
        self.buttonStackView.spacing = 15.0
        
        self.hostButton.setTitle("近くの友達に招待を送る", for: .normal)
        self.hostButton.addTarget(self, action: #selector(self.tappedHostButton), for: .touchUpInside)
        
        self.guestButton.setTitle("友達の招待を受け取る", for: .normal)
        self.guestButton.addTarget(self, action: #selector(self.tappedGuestButton), for: .touchUpInside)
        
        self.sendFavoriteButton.setTitle("お気に入りを送る", for: .normal)
        self.sendFavoriteButton.addTarget(self, action: #selector(self.tappedSendFavorite), for: .touchUpInside)
        
        self.disconnectButton.setTitle("接続を解除する", for: .normal)
        self.disconnectButton.addTarget(self, action: #selector(self.tappedDisconnectButton), for: .touchUpInside)
        
        self.hostButton.isHidden = false
        self.guestButton.isHidden = false
        self.sendFavoriteButton.isHidden = true
        self.disconnectButton.isHidden = true
        
        self.wifiDescriptionLabel.text = "※端末のWiFiとBluetoothをONにしてください。"
        self.wifiDescriptionLabel.numberOfLines = 2
        
        self.loadingDescriptionLabel.text = "※お気に入りの交換には数分かかる事があります。"
        self.loadingDescriptionLabel.numberOfLines = 2
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.statusLabel.textColor = .black
        self.statusLabel.font = .boldSystemFont(ofSize: 15.0)
        
        self.hintButton.layer.cornerRadius = 10.0
        self.hintButton.clipsToBounds = true
        
        self.hintIcon.isUserInteractionEnabled = false
        
        self.hostButton.backgroundColor = CustomUIColor.turquoise
        self.hostButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.hostButton.setTitleColor(.white, for: .normal)
        self.hostButton.layer.cornerRadius = 5.0
        self.hostButton.layer.borderColor = CustomUIColor.turquoise.cgColor
        self.hostButton.layer.borderWidth = 1.0
        
        self.guestButton.backgroundColor = CustomUIColor.turquoise
        self.guestButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.guestButton.setTitleColor(.white, for: .normal)
        self.guestButton.layer.cornerRadius = 5.0
        self.guestButton.layer.borderColor = CustomUIColor.turquoise.cgColor
        self.guestButton.layer.borderWidth = 1.0
        
        self.sendFavoriteButton.backgroundColor = CustomUIColor.turquoise
        self.sendFavoriteButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.sendFavoriteButton.setTitleColor(.white, for: .normal)
        self.sendFavoriteButton.layer.cornerRadius = 5.0
        self.sendFavoriteButton.layer.borderColor = CustomUIColor.turquoise.cgColor
        self.sendFavoriteButton.layer.borderWidth = 1.0
        
        self.disconnectButton.backgroundColor = .white
        self.disconnectButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.disconnectButton.setTitleColor(.red, for: .normal)
        
        self.wifiDescriptionLabel.textColor = .black
        self.wifiDescriptionLabel.font = .systemFont(ofSize: 12.0)
        
        self.loadingDescriptionLabel.textColor = .black
        self.loadingDescriptionLabel.font = .systemFont(ofSize: 12.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.statusLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.statusLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.statusLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.hintButton.autoAlignAxis(.horizontal, toSameAxisOf: self.statusLabel)
        self.hintButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        self.hintButton.autoSetDimensions(to: CGSize(width: 20.0, height: 20.0))
        
        self.hintIcon.autoPinEdgesToSuperviewEdges()
        
        self.imageView.autoPinEdge(.top, to: .bottom, of: self.statusLabel, withOffset: 20.0)
        self.imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: 20.0)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .left)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .right)
        self.friendStackView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        self.buttonStackView.autoPinEdge(.top, to: .bottom, of: self.friendStackView, withOffset: 30.0)
        self.buttonStackView.autoPinEdge(toSuperviewEdge: .left)
        self.buttonStackView.autoPinEdge(toSuperviewEdge: .right)
        
        self.hostButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.hostButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.hostButton.autoSetDimension(.height, toSize: 44.0)
        
        self.guestButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.guestButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.guestButton.autoSetDimension(.height, toSize: 44.0)
        
        self.sendFavoriteButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.sendFavoriteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.sendFavoriteButton.autoSetDimension(.height, toSize: 44.0)
        
        self.disconnectButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.disconnectButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.disconnectButton.autoSetDimension(.height, toSize: 44.0)
        
        self.wifiDescriptionLabel.autoPinEdge(.top, to: .bottom, of: self.buttonStackView, withOffset: 30.0)
        self.wifiDescriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.wifiDescriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.loadingDescriptionLabel.autoPinEdge(.top, to: .bottom, of: self.wifiDescriptionLabel, withOffset: 5.0)
        self.loadingDescriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.loadingDescriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.loadingDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30.0)
        
        self.indicator.autoCenterInSuperview()
    }
    
    @objc private func tappedHintButton() {
        let tutorialView = CustomNavigationController(rootViewController: ExchangeTutorialViewController())
        
        self.present(tutorialView, animated: true)
    }
    
    @objc private func tappedHostButton() {
        // 近くの端末を検索する
        self.browser.startBrowsingForPeers()
        
        // 2秒くらいボタンの色を薄くして、押した感を出す。連続タップも出来ない様に
        self.hostButton.alpha = 0.6
        self.hostButton.isEnabled = false

        DispatchQueue.main.async {
            UIImageView.animate(
                withDuration: 2.0,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    self.hostButton.alpha = 1.0
                    self.hostButton.isEnabled = true
                }
            )
        }
    }
    
    @objc private func tappedGuestButton() {
        // 近くの検索している人を探す
        self.advertiser.startAdvertisingPeer()
        
        // 2秒くらいボタンの色を薄くして、押した感を出す。連続タップも出来ない様に
        self.guestButton.alpha = 0.6
        self.guestButton.isEnabled = false

        DispatchQueue.main.async {
            UIImageView.animate(
                withDuration: 2.0,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    self.guestButton.alpha = 1.0
                    self.guestButton.isEnabled = true
                }
            )
        }
    }
    
    @objc private func tappedFriendView(_ sender: FriendView) {
        // 相手のIDに対して招待を送信する
        if let unwrappedPeerID = sender.peerID {
            self.browser.invitePeer(unwrappedPeerID, to: self.session, withContext: nil, timeout: 0.0)
        }
    }
    
    @objc private func tappedSendFavorite() {
        // インジケータを回す
        self.indicator.startAnimating()
        self.sendFavoriteButton.isEnabled = false
        
        // 相手側でのキャッシュ管理のため、ユニークキーも送信しておく
        self.sendUniqueKey()
        
        // お気に入り一覧を送る
        for category in FavoriteCategory.allCases {
            let favoriteData = self.getMyFavoriteAsData(category: category)
            
            // データを相手の端末に送信する
            if let unwrappedFavoriteData = favoriteData {
                do {
                    try self.session.send(
                        unwrappedFavoriteData, toPeers: self.session.connectedPeers, with: .unreliable
                    )
                    
                    print("成功したよ")
                } catch let error {
                    print("失敗したよ\(error)")
                }
            } else {
                print("そのカテゴリは空だよ")
            }
        }
        
        // プロフィールを送信する
        self.sendUserInfo()
        
        // 2秒くらいボタンの色を薄くして、押した感を出す。連続タップも出来ない様に
        self.sendFavoriteButton.alpha = 0.6
        self.sendFavoriteButton.isEnabled = false

        DispatchQueue.main.async {
            UIImageView.animate(
                withDuration: 2.0,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    self.sendFavoriteButton.alpha = 1.0
                    self.sendFavoriteButton.isEnabled = true
                }
            )
        }
    }
    
    // 現在保持しているお気に入りをカテゴリごとにキャッシュから取得する
    private func getMyFavoriteAsData(category: FavoriteCategory) -> Data? {
        return UserDefaults.standard.object(forKey: category.rawValue) as? Data
    }
    
    private func getMyUserInfoAsData() -> Data? {
        return UserDefaults.standard.object(forKey: UserDefaultKeys.userInfo) as? Data
    }
    
    @objc private func tappedDisconnectButton() {
        // 切断する時に全ての友達カードを消す
        DispatchQueue.main.async {
            self.friendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        }
        
        self.session.disconnect()
        self.advertiser.stopAdvertisingPeer()
        self.browser.stopBrowsingForPeers()
    }
    
    
    // ユニークキーの送信
    private func sendUniqueKey() {
        if let uniqueKey = UserDefaults.standard.object(forKey: UserDefaultKeys.uniqueKey) as? String {
            do {
                try self.session.send(uniqueKey.data(using: .utf8)!, toPeers: self.session.connectedPeers, with: .reliable)
                
                print("ユニークキー送ったよ")
            } catch let error {
                print("ユニークキー送れなかったよ\(error)")
            }
        } else {
            //　ユニークキーがなければ、UUIDから作成してキャッシュに保存しておく
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: UserDefaultKeys.uniqueKey)
            
            do {
                try self.session.send(uuid.data(using: .utf8)!, toPeers: self.session.connectedPeers, with: .reliable)
                
                print("初めてユニークキー送ったよ")
            } catch let error {
                print("初めてユニークキー送れなかったよ\(error)")
            }
        }
    }
    
    // プロフィールを送信する
    private func sendUserInfo() {
        if let myUserInfo = self.getMyUserInfoAsData() {
            do {
                try self.session.send(myUserInfo, toPeers: self.session.connectedPeers, with: .reliable)
                
                print("プロフィールの送信")
            } catch let error {
                print("プロフィールの送信失敗\(error)")
            }
        } else {
            print("プロフィールがありません")
        }
    }
}

// 他のデバイスを検索する時の処理を書く
extension ExchangeViewController: MCNearbyServiceBrowserDelegate {
    // 検索した後に他の端末を見つけたら呼ばれる
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID, // 検索して見つかった相手のID
        withDiscoveryInfo info: [String : String]?
    ) {
        // 友達を発見した時に振動フィードバックを入れる
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        // 友達のカードを作成する
        let friendView = FriendView()
        friendView.peerID = peerID
        
        // スタックビューの更新
        DispatchQueue.main.async {
            // 既にそのカードがなければ新規追加する
            let matchedFriendViewList = self.friendStackView.arrangedSubviews.filter { ($0 as? FriendView)?.peerID == peerID }
            
            if matchedFriendViewList.isEmpty {
                self.friendStackView.addArrangedSubview(friendView)
                
                friendView.autoPinEdge(toSuperviewEdge: .left ,withInset: 16.0)
                friendView.autoPinEdge(toSuperviewEdge: .right ,withInset: 16.0)
                
                // タップ時にその友達に対して招待を送る設定をしておく
                friendView.addTarget(self, action: #selector(self.tappedFriendView(_:)), for: .touchUpInside)
            }
        }
    }

    // 他の端末との接続が切れたら呼ばれる
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // 「接続が切れたよ」メッセージを出す
        Toast.show("接続が切断されました", self.view)
    }
}

// 他のデバイスからの招待を受信した際の処理を書く
extension ExchangeViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // 招待を受信時に振動フィードバックを入れる
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        let alertController = UIAlertController(
            title: "\(peerID.displayName)さんと接続しますか？", message: nil, preferredStyle: .alert
        )
        let acceptAction = UIAlertAction(title: "接続する", style: .default) { (action) in
            // trueにすると招待を受けることになる
            invitationHandler(true, self.session)
        }
        let deniedAction = UIAlertAction(title: "接続しない", style: .destructive) { (action) in
            // trueにすると招待を受けることになる
            invitationHandler(true, self.session)
        }
        
        DispatchQueue.main.async {
            alertController.addAction(acceptAction)
            alertController.addAction(deniedAction)
            
            // アラートを出す
            self.present(alertController, animated: true)
        }
    }
}

extension ExchangeViewController: MCSessionDelegate {
    // 他のデバイスとの接続状態が変わったときに呼ばれる
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        let message: String
        switch state {
        case .connected:
            // 接続成功のハプティックフィードバックを入れる
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            message = "\(peerID.displayName)さんと接続されました"
            
            // 接続されたのでお気に入りを送るボタンを表示する
            DispatchQueue.main.async {
                self.hostButton.isHidden = true
                self.guestButton.isHidden = true
                self.sendFavoriteButton.isHidden = false
                self.disconnectButton.isHidden = false
                
                // 既存の友達カードを接続中に変更する
                for subview in self.friendStackView.arrangedSubviews {
                    if let friendView = subview as? FriendView, friendView.peerID == peerID {
                        friendView.inviteLabel.text = "接続中"
                        friendView.isEnabled = false
                    }
                }
                
                // まだ友達カードが存在しない場合は新たに追加する
                if self.friendStackView.arrangedSubviews.isEmpty {
                    DispatchQueue.main.async {
                        // まだカードがない状態なので、友達のカードを作成する
                        let friendView = FriendView()
                        friendView.peerID = peerID
                        friendView.inviteLabel.text = "接続中"
                        friendView.isEnabled = false
                        
                        self.friendStackView.addArrangedSubview(friendView)
                        
                        friendView.autoPinEdge(toSuperviewEdge: .left ,withInset: 16.0)
                        friendView.autoPinEdge(toSuperviewEdge: .right ,withInset: 16.0)
                        
                        // タップ時にその友達に対して招待を送る設定をしておく
                        friendView.addTarget(self, action: #selector(self.tappedFriendView(_:)), for: .touchUpInside)
                    }
                }
            }
        case .connecting:
            message = "\(peerID.displayName)さんと接続中です"
        case .notConnected:
            message = "\(peerID.displayName)さんとの通信が切断されました"
            
            // 切断されたのでお気に入りを送るボタンを隠す
            DispatchQueue.main.async {
                // 切断する時に全ての友達カードを消す
                self.friendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                
                self.disconnectButton.isHidden = true
                
                for subview in self.friendStackView.arrangedSubviews {
                    if
                        let friendView = subview as? FriendView,
                        friendView.peerID == peerID
                    {
                        friendView.inviteLabel.text = "招待する"
                        friendView.isEnabled = true
                    }
                }
                
                self.hostButton.isHidden = false
                self.guestButton.isHidden = false
                self.sendFavoriteButton.isHidden = true
                self.disconnectButton.isHidden = true
            }
        @unknown default:
            message = "\(peerID.displayName)さんとの通信が想定外の状態です"
        }
        
        // 最新のステータスをラベルに出してあげる
        DispatchQueue.main.async {
            self.statusLabel.text = message
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("データが届いたよ")
        
        if let favoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite] {
            // 3.受け取ったお気に入りをプロパティに保持する
            self.recievedFavoriteList.append(contentsOf: favoriteList)
            
            // 4.ユニークキーでそのお気に入りを保存する
            if let unwrappedUniqueKey = self.recievedUniqueKey {
                let archivedFavoriteList = try! NSKeyedArchiver.archivedData(withRootObject: self.recievedFavoriteList, requiringSecureCoding: false)
                UserDefaults.standard.set(archivedFavoriteList, forKey: unwrappedUniqueKey)
            }
        } else if let messageString = String(data: data, encoding: .utf8) {
            // 7. 全ての通信が終了したら"finish sending"が相手から飛んでくるので、インジケータを止める
            if messageString == "finish sending" {
                DispatchQueue.main.async {
                    Toast.show("お気に入りを送信しました", self.view)
                    self.indicator.stopAnimating()
                    self.sendFavoriteButton.isEnabled = true
                    
                    self.statusLabel.text = "お気に入りを送信しました。"
                }
            } else {
                // インジケータ開始
                DispatchQueue.main.async {
                    self.indicator.startAnimating()
                    self.sendFavoriteButton.isEnabled = false
                }
                
                print("ユニークキーは\(messageString)")
                
                // 1.ユニークキーをプロパティとして保持する
                self.recievedUniqueKey = messageString
                
                // 2.友達リストに追加する
                var newFriendList: [String : String] = [:]
                if let friendList = UserDefaults.standard.object(forKey: UserDefaultKeys.friendList) as? [String : String] {
                    newFriendList = friendList // 既にある場合は取得
                }
                
                // リストを更新・保存する
                newFriendList[messageString] = peerID.displayName
                UserDefaults.standard.set(newFriendList, forKey: UserDefaultKeys.friendList)
            }
        } else if let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo {
            // プロフィール受け取ったらインジケータ終了
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.sendFavoriteButton.isEnabled = true

                Toast.show("お気に入りを受信しました", self.view)
                
                self.statusLabel.text = "お気に入りを受信しました。「友達」タブを見てみましょう！"
            }
            
            // 5.ユニークキーでそのプロフィールを保存する
            if let unwrappedUniqueKey = self.recievedUniqueKey {
                let profileKey = unwrappedUniqueKey + "_profile"
                
                let archivedUserInfo = try! NSKeyedArchiver.archivedData(withRootObject: userInfo, requiringSecureCoding: false)
                UserDefaults.standard.set(archivedUserInfo, forKey: profileKey)
            }
            
            // 6. 終わったら空にしておく
            self.recievedUniqueKey = ""
            self.recievedFavoriteList = []
            
            // 7. 相手に終わったよメッセージを送る
            do {
                let finishMessage = "finish sending"
                try self.session.send(finishMessage.data(using: .utf8)!, toPeers: self.session.connectedPeers, with: .reliable)
                
                print("受信完了メッセージを送るよ")
            } catch let error {
                print("終了通知の送信失敗\(error)")
            }
        } else {
            print("想定外のデータだよ")
        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        assertionFailure("非対応")
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        assertionFailure("非対応")
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        assertionFailure("非対応")
    }
}
