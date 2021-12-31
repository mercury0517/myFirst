import UIKit
import MultipeerConnectivity

class FriendView: UIControl {
    var peerID: MCPeerID? {
        didSet {
            self.nameLabel.text = self.peerID?.displayName
        }
    }
    
    let nameLabel = UILabel()
    let inviteLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func addSubviews() {
        self.addSubview(self.nameLabel)
        self.addSubview(self.inviteLabel)
    }
    
    private func configSubViews() {
        self.nameLabel.text = "名前がありません"
        
        self.inviteLabel.text = "招待する"
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        
        self.nameLabel.textColor = .black
        self.nameLabel.font = UIFont(name: "Oswald", size: 20.0)
        
        self.inviteLabel.textColor = CustomUIColor.turquoise
        self.inviteLabel.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.nameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
        
        self.inviteLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.nameLabel)
        self.inviteLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
}
