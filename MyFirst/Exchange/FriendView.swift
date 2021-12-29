import UIKit
import MultipeerConnectivity

class FriendView: UIControl {
    let peerID: MCPeerID
    
    let nameLabel = UILabel()
    let inviteLabel = UILabel()
    
    init(peerID: MCPeerID) {
        self.peerID = peerID
        
        super.init(frame: .zero)
        
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
        self.nameLabel.text = peerID.displayName
        
        self.inviteLabel.text = "INVITE"
    }
    
    private func applyStyling() {
        self.backgroundColor = .cyan
        
        self.nameLabel.textColor = .black
        self.nameLabel.font = UIFont(name: "Oswald", size: 15.0)
        
        self.inviteLabel.textColor = CustomUIColor.turquoise
        self.inviteLabel.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.autoPinEdgesToSuperviewEdges()
        
        self.nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.inviteLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.nameLabel)
        self.inviteLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
}
