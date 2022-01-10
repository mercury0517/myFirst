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
    
    var isHideDeleteButton: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.deleteButton.isHidden = self.isHideDeleteButton
            }
        }
    }
    
    var alertController = UIAlertController(
        title: "この友達のお気に入りを削除しますか？", message: nil, preferredStyle: .alert
    )
    
    var deleteAlertAcrion: (() -> Void)?
    var deleteAction: (() -> Void)?
    
    let iconImageView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    let nameLabel = UILabel()
    let deleteButton = UIButton()
    
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
        self.addSubview(self.deleteButton)
    }
    
    private func configSubViews() {
        self.customDeleteFavoriteAlert()
        
        self.nameLabel.text = "YOUR FRIEND"
        
        self.deleteButton.setTitle("削除", for: .normal)
        self.deleteButton.addTarget(self, action: #selector(self.tappedDeleteButton), for: .touchUpInside)
        
        self.deleteButton.isHidden = true
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
        
        self.deleteButton.setTitleColor(.red, for: .normal)
        self.deleteButton.titleLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    private func addConstraints() {
        self.iconImageView.autoSetDimensions(to: CGSize(width: 60.0, height: 60.0))
        self.iconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.iconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.iconImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
        
        self.nameLabel.autoPinEdge(.left, to: .right, of: self.iconImageView, withOffset: 15.0)
        self.nameLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.iconImageView)
        
        self.deleteButton.autoPinEdge(.left, to: .right, of: self.nameLabel, withOffset: 10.0)
        self.deleteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.deleteButton.autoAlignAxis(.horizontal, toSameAxisOf: self.iconImageView)
    }
    
    private func customDeleteFavoriteAlert() {
        let deleteAction = UIAlertAction(title: "削除する", style: .destructive) { (action) in
            // execute completion
            if let action = self.deleteAction {
                // 削除処理
                action()
                
                // キャッシュからも削除
                if
                    let friendList = UserDefaults.standard.object(forKey: UserDefaultKeys.friendList) as? [String : String],
                    let unwrappedUniqueKey = self.uniqueKey
                {
                    var newFriendList = friendList
                    newFriendList[unwrappedUniqueKey] = nil
                    
                    // キャッシュの更新
                    UserDefaults.standard.set(newFriendList, forKey: UserDefaultKeys.friendList)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: nil)
        }
        
        self.alertController.addAction(deleteAction)
        self.alertController.addAction(cancelAction)
    }
    
    @objc private func tappedDeleteButton() {
        if let unwrappedDeleteAlertAcrion = self.deleteAlertAcrion {
            unwrappedDeleteAlertAcrion()
        }
    }
}
