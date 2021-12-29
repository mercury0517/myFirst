import UIKit
import AudioToolbox
import MultipeerConnectivity // 通信を行う為に必要なモジュール

class ExchangeViewController: UIViewController {
    // ユーザー識別用のID
    private let peerID = MCPeerID.init(
        displayName: (
            UserDefaults.standard.object(forKey: "userInfo") as? UserInfo
        )?.name ?? "unknown"
    )
    // サービス識別用の任意の文字列
    private let serviceType = "favorite"
    
    // 他の端末を探したり、招待を送る為に使用
    private var browser: MCNearbyServiceBrowser!
    
    // 他の端末から招待を受け取る為に使用
    private var advertiser: MCNearbyServiceAdvertiser!
    
    // 実際にデータの送受信を行う為に使用
    private var session: MCSession!
    
    let statusLabel = UILabel()
    let friendStackView = UIStackView()
    let findFriendButton = UIButton()
    
    init() {
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
        self.view.addSubview(self.friendStackView)
        self.view.addSubview(self.findFriendButton)
    }
    
    private func configSubViews() {
        self.statusLabel.text = "まだ接続されてないよ"
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 0.0
        
        self.findFriendButton.setTitle("FIND FRIEND", for: .normal)
        self.findFriendButton.addTarget(self, action: #selector(self.tappedFindFriendButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.findFriendButton.backgroundColor = CustomUIColor.turquoise
        self.findFriendButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.findFriendButton.contentEdgeInsets = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)
    }
    
    private func addConstraints() {
        self.statusLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100.0)
        self.statusLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.statusLabel, withOffset: 20.0)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .left)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .right)
        
        self.findFriendButton.autoPinEdge(.top, to: .bottom, of: self.friendStackView, withOffset: 20.0)
        self.findFriendButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    @objc private func tappedFindFriendButton() {
        // 近くの端末を検索する
        self.browser.startBrowsingForPeers()
        
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

extension ExchangeViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        let message: String
        switch state {
        case .connected:
            message = "\(peerID.displayName)が接続されました"
        case .connecting:
            message = "\(peerID.displayName)が接続中です"
        case .notConnected:
            message = "\(peerID.displayName)が切断されました"
        @unknown default:
            message = "\(peerID.displayName)が想定外の状態です"
        }
        
        DispatchQueue.main.async {
            self.statusLabel.text = message
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let message = String(data: data, encoding: .utf8) else {
            return
        }
        
        DispatchQueue.main.async {
            print("やりたい事を書く")
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

// 他のデバイスに対して招待を送信する際の処理を書く
extension ExchangeViewController: MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        invitationHandler(true, session)
    }
}
