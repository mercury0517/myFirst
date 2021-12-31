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
    
    let statusLabel = UILabel()
    let messageLabel = UILabel()
    
    let friendStackView = UIStackView()
    
    let hostButton = UIButton() // hostになる
    let guestButton = UIButton() // guestになる
    let sendFavoriteButton = UIButton()
    
    init() {
        if
            let data = UserDefaults.standard.object(forKey: "userInfo") as? Data,
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo
        {
            self.peerID = MCPeerID.init(displayName: userInfo.name)
        } else {
            self.peerID = MCPeerID.init(displayName: "unknown")
        }
        
        // 通信に必要なオブジェクトの初期化
        self.browser = MCNearbyServiceBrowser(peer: self.peerID, serviceType: self.serviceType)
        self.advertiser = MCNearbyServiceAdvertiser(peer: self.peerID, discoveryInfo: nil, serviceType: self.serviceType)
        self.session = MCSession(peer: self.peerID)
        
        super.init(nibName: nil, bundle: nil)
        
        self.browser.delegate = self
        self.advertiser.delegate = self
        self.session.delegate = self
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // 他の画面に遷移したタイミングで、通信で使用していたものを全て止める
        self.session.disconnect()
        self.advertiser.stopAdvertisingPeer()
        self.browser.stopBrowsingForPeers()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.statusLabel)
        self.view.addSubview(self.messageLabel)
        self.view.addSubview(self.friendStackView)
        self.view.addSubview(self.hostButton)
        self.view.addSubview(self.guestButton)
        self.view.addSubview(self.sendFavoriteButton)
    }
    
    private func configSubViews() {
        self.statusLabel.text = "まだ接続されてないよ"
        self.messageLabel.text = "メッセージはありません"
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 0.0
        
        self.hostButton.setTitle("友達に招待を送る", for: .normal)
        self.hostButton.addTarget(self, action: #selector(self.tappedHostButton), for: .touchUpInside)
        
        self.guestButton.setTitle("友達の招待を受け取る", for: .normal)
        self.guestButton.addTarget(self, action: #selector(self.tappedGuestButton), for: .touchUpInside)
        
        self.sendFavoriteButton.setTitle("お気に入りを送る", for: .normal)
        self.sendFavoriteButton.addTarget(self, action: #selector(self.tappedSendFavorite), for: .touchUpInside)
        
        self.sendFavoriteButton.isEnabled = false
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.statusLabel.textColor = .black
        
        self.messageLabel.textColor = .black
        
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
        
        self.sendFavoriteButton.backgroundColor = .white
        self.sendFavoriteButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.sendFavoriteButton.setTitleColor(CustomUIColor.turquoise, for: .normal)
        self.sendFavoriteButton.layer.cornerRadius = 5.0
        self.sendFavoriteButton.layer.borderColor = CustomUIColor.turquoise.cgColor
        self.sendFavoriteButton.layer.borderWidth = 1.0
    }
    
    private func addConstraints() {
        self.statusLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100.0)
        self.statusLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.messageLabel.autoPinEdge(.top, to: .bottom, of: self.statusLabel, withOffset: 10.0)
        self.messageLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.messageLabel, withOffset: 20.0)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .left)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .right)
        
        self.hostButton.autoPinEdge(.top, to: .bottom, of: self.friendStackView, withOffset: 50.0)
        self.hostButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.hostButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.hostButton.autoSetDimension(.height, toSize: 44.0)
        
        self.guestButton.autoPinEdge(.top, to: .bottom, of: self.hostButton, withOffset: 20.0)
        self.guestButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.guestButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.guestButton.autoSetDimension(.height, toSize: 44.0)
        
        self.sendFavoriteButton.autoPinEdge(.top, to: .bottom, of: self.guestButton, withOffset: 20.0)
        self.sendFavoriteButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.sendFavoriteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.sendFavoriteButton.autoSetDimension(.height, toSize: 44.0)
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
        // TODO: インジケータを表示する
        
        // 相手側でのキャッシュ管理のため、ユニークキーも送信しておく
        self.sendUniqueKey()
        
        // お気に入り情報の送信
        for category in FavoriteCategory.allCases {
            let favoriteData = self.getMyFavoriteAsData(category: category)
            
            // データを相手の端末に送信する
            if let unwrappedFavoriteData = favoriteData {
                do {
                    try self.session.send(unwrappedFavoriteData, toPeers: self.session.connectedPeers, with: .reliable)
                    
                    print("成功したよ")
                } catch let error {
                    Toast.show("you can't send message: \(error)", self.view)
                    
                    print("失敗したよ")
                }
            } else {
                print("そのカテゴリは空だよ")
            }
        }
    }
    
    // 現在保持しているお気に入りをカテゴリごとにキャッシュから取得する
    private func getMyFavoriteAsData(category: FavoriteCategory) -> Data? {
        return UserDefaults.standard.object(forKey: category.rawValue) as? Data
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
            self.friendStackView.addArrangedSubview(friendView)

            friendView.autoPinEdge(toSuperviewEdge: .left ,withInset: 16.0)
            friendView.autoPinEdge(toSuperviewEdge: .right ,withInset: 16.0)

            // タップ時にその友達に対して招待を送る設定をしておく
            friendView.addTarget(self, action: #selector(self.tappedFriendView(_:)), for: .touchUpInside)
        }
    }

    // 他の端末との接続が切れたら呼ばれる
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // 「接続が切れたよ」メッセージを出す
        Toast.show("Connection to other devices has been lost.", self.view)
    }
}

// 他のデバイスからの招待を受信した際の処理を書く
extension ExchangeViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // 招待を受信時に振動フィードバックを入れる
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        let alertController = UIAlertController(
            title: "\(peerID.displayName)さんから招待が来ています", message: nil, preferredStyle: .alert
        )
        let acceptAction = UIAlertAction(title: "受け入れる", style: .default) { (action) in
            // trueにすると招待を受けることになる
            invitationHandler(true, self.session)
        }
        let deniedAction = UIAlertAction(title: "辞退する", style: .destructive) { (action) in
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
                for subview in self.friendStackView.arrangedSubviews {
                    if
                        let friendView = subview as? FriendView,
                        friendView.peerID == peerID
                    {
                        friendView.inviteLabel.text = "接続中"
                        friendView.isEnabled = false
                    } else {
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
                
                self.hostButton.isEnabled = false
                self.hostButton.backgroundColor = .white
                self.hostButton.setTitleColor(CustomUIColor.turquoise, for: .normal)
                
                self.guestButton.isEnabled = false
                self.guestButton.backgroundColor = .white
                self.guestButton.setTitleColor(CustomUIColor.turquoise, for: .normal)
                
                self.sendFavoriteButton.isEnabled = true
                self.sendFavoriteButton.backgroundColor = CustomUIColor.turquoise
                self.sendFavoriteButton.setTitleColor(.white, for: .normal)
            }
        case .connecting:
            message = "\(peerID.displayName)さんと接続中です"
        case .notConnected:
            message = "\(peerID.displayName)さんとの通信が切断されました"
            
            // 切断されたのでお気に入りを送るボタンを隠す
            DispatchQueue.main.async {
                for subview in self.friendStackView.arrangedSubviews {
                    if
                        let friendView = subview as? FriendView,
                        friendView.peerID == peerID
                    {
                        friendView.inviteLabel.text = "招待する"
                        friendView.isEnabled = true
                    }
                }
                
                self.hostButton.isEnabled = true
                self.hostButton.backgroundColor = CustomUIColor.turquoise
                self.hostButton.setTitleColor(.white, for: .normal)
                
                self.guestButton.isEnabled = true
                self.guestButton.backgroundColor = CustomUIColor.turquoise
                self.guestButton.setTitleColor(.white, for: .normal)
                
                self.sendFavoriteButton.isEnabled = false
                self.sendFavoriteButton.backgroundColor = .white
                self.sendFavoriteButton.setTitleColor(CustomUIColor.turquoise, for: .normal)
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
        // TODO: インジケータを表示する
        print("データが届いたよ")
        
        if let favoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite] {
            // TODO: このお気に入りを相手のuuidに紐づいた形でキャッシュに保存する
            print("お気に入りを取り出せたよ")
            
            for favorite in favoriteList {
                print(favorite.title)
                
                DispatchQueue.main.async {
                    self.messageLabel.text = favorite.title
                }
            }
        } else if let uniqueKey = String(data: data, encoding: .utf8) {
            print("ユニークキーは\(uniqueKey)")
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
