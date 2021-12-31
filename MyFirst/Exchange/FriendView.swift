import UIKit
import MultipeerConnectivity

class FriendView: UIControl {
    var peerID: MCPeerID? {
        didSet {
            self.nameLabel.text = self.peerID?.displayName
        }
    }
    
    let nameLabel = UILabel()
    let inviteButton = UIButton()
    
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
        self.addSubview(self.inviteButton)
    }
    
    private func configSubViews() {
        self.nameLabel.text = "名前がありません"
        
        self.inviteButton.setTitle("招待する", for: .normal)
    }
    
    private func applyStyling() {
        self.backgroundColor = .lightGray
        
        self.nameLabel.textColor = .black
        self.nameLabel.font = UIFont(name: "Oswald", size: 20.0)
        
        self.inviteButton.setTitleColor(CustomUIColor.turquoise, for: .normal)
        self.inviteButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
    }
    
    private func addConstraints() {
        self.nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.nameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
        
        self.inviteButton.autoAlignAxis(.horizontal, toSameAxisOf: self.nameLabel)
        self.inviteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
}
