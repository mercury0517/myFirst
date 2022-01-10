import UIKit

class FriendCardView: UIControl {
    var uniqueKey: String?
    var displayName: String? {
        didSet {
            self.nameLabel.text = self.displayName
        }
    }
    var userInfo: UserInfo? {
        didSet {
            self.iconImageView.image = self.userInfo?.icon
            self.nameLabel.text = self.userInfo?.name
        }
    }
    
    let iconImageView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    let nameLabel = UILabel()
    
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
        self.addSubview(self.iconImageView)
        self.addSubview(self.nameLabel)
    }
    
    private func configSubViews() {
        self.nameLabel.text = "UNKNOWN"
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        
        self.iconImageView.layer.cornerRadius = 30.0
        self.iconImageView.clipsToBounds = true
        
        self.nameLabel.textColor = .black
        self.nameLabel.font = UIFont(name: "Oswald", size: 22.0)
    }
    
    private func addConstraints() {
        self.iconImageView.autoSetDimensions(to: CGSize(width: 60.0, height: 60.0))
        self.iconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.iconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.iconImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
        
        self.nameLabel.autoPinEdge(.left, to: .right, of: self.iconImageView, withOffset: 15.0)
        self.nameLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.iconImageView)
        self.nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
}
