import UIKit
import AudioToolbox
import MultipeerConnectivity // 通信を行う為に必要なモジュール

class ExchangeViewController: UIViewController {
    /*
     ユーザー識別用のID。
     画面に表示させることも出来るので、ユーザーネームとかを設定しておくと良い。
    */
    private let peerID = MCPeerID.init(
        displayName: (
            UserDefaults.standard.object(forKey: "userInfo") as? UserInfo
        )?.name ?? "unknown"
    )
    
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
    let findFriendButton = UIButton() // browserで友達を探す
    
    let sendFavoriteButton = UIButton()
    
    init() {
        // 通信に必要なオブジェクトの初期化
        self.browser = MCNearbyServiceBrowser(peer: self.peerID, serviceType: self.serviceType)
        self.advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: self.serviceType)
        self.session = MCSession(peer: self.peerID)
        
        super.init(nibName: nil, bundle: nil)
        
        self.browser.delegate = self
        self.advertiser.delegate = self
        self.session.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        // 近くの端末を検索する
        self.advertiser.startAdvertisingPeer()
        self.browser.startBrowsingForPeers()
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
        self.view.addSubview(self.findFriendButton)
        self.view.addSubview(self.sendFavoriteButton)
    }
    
    private func configSubViews() {
        self.statusLabel.text = "まだ接続されてないよ"
        self.messageLabel.text = "メッセージはありません"
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 0.0
        
        self.findFriendButton.setTitle("FIND FRIEND", for: .normal)
        self.findFriendButton.addTarget(self, action: #selector(self.tappedFindFriendButton), for: .touchUpInside)
        
        self.sendFavoriteButton.setTitle("SEND FAVORITE", for: .normal)
        self.sendFavoriteButton.isHidden = true
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.statusLabel.textColor = .black
        
        self.messageLabel.textColor = .black
        
        self.findFriendButton.backgroundColor = CustomUIColor.turquoise
        self.findFriendButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.findFriendButton.contentEdgeInsets = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)
        
        self.sendFavoriteButton.backgroundColor = .magenta
        self.sendFavoriteButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.sendFavoriteButton.contentEdgeInsets = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)
    }
    
    private func addConstraints() {
        self.statusLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100.0)
        self.statusLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.messageLabel.autoPinEdge(.top, to: .bottom, of: self.statusLabel, withOffset: 10.0)
        self.messageLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.messageLabel, withOffset: 20.0)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .left)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .right)
        
        self.findFriendButton.autoPinEdge(.top, to: .bottom, of: self.friendStackView, withOffset: 20.0)
        self.findFriendButton.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.sendFavoriteButton.autoPinEdge(.top, to: .bottom, of: self.findFriendButton, withOffset: 20.0)
        self.sendFavoriteButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    @objc private func tappedFindFriendButton() {
        // 2秒くらいボタンの色を薄くして、押した感を出す。連続タップも出来ない様に
        self.findFriendButton.alpha = 0.3
        self.findFriendButton.isEnabled = false
            
        DispatchQueue.main.async {
            UIImageView.animate(
                withDuration: 2.0,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    self.findFriendButton.alpha = 1.0
                    self.findFriendButton.isEnabled = true
                }
            )
        }
    }
    
    @objc private func tappedFriendView(_ sender: FriendView) {
        // 相手のIDに対して招待を送信する
        self.browser.invitePeer(sender.peerID, to: self.session, withContext: nil, timeout: 60.0)
    }
    
    @objc private func tappedSendButton() {
        let message = "\(session.myPeerID.displayName)からのメッセージ"
        do {
            try self.session.send(message.data(using: .utf8)!, toPeers: self.session.connectedPeers, with: .reliable)
        } catch let error {
            Toast.show("you can't send message: \(error)", self.view)
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
        let friendView = FriendView(peerID: peerID)
        
        // スタックビューの更新
        DispatchQueue.main.async {
            self.friendStackView.addArrangedSubview(friendView)
            
            friendView.autoPinEdge(toSuperviewEdge: .left)
            friendView.autoPinEdge(toSuperviewEdge: .right)
            
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
        
        // trueにすると招待を受けることになる(ここはハンドリングしても良い)
        invitationHandler(true, self.session)
        
        // お気に入りを送るボタンを表示させる
        DispatchQueue.main.async {
            self.sendFavoriteButton.isHidden = false
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
            
            message = "\(peerID.displayName)が接続されました"
        case .connecting:
            message = "\(peerID.displayName)が接続中です"
        case .notConnected:
            message = "\(peerID.displayName)が切断されました"
        @unknown default:
            message = "\(peerID.displayName)が想定外の状態です"
        }
        
        // 最新のステータスをラベルに出してあげる
        DispatchQueue.main.async {
            self.statusLabel.text = message
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let message = String(data: data, encoding: .utf8) else {
            return
        }
        
        // 受け取ったメッセージを表示する
        DispatchQueue.main.async {
            self.messageLabel.text = message
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
