import AudioToolbox
import UIKit

class FriendListViewController: UIViewController {
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    
    let editButton = UIControl()
    let editIcon = UIImageView(image: UIImage(named: "edit_icon"))
    
    let friendStackView = UIStackView()
    
    var isEditMode: Bool = false {
        didSet {
            if self.isEditMode {
                DispatchQueue.main.async {
                    self.editIcon.image = UIImage(named: "return")
                    self.editButton.backgroundColor = .white
                    self.editButton.layer.borderColor = UIColor.gray.cgColor
                    self.editButton.layer.borderWidth = 1.0
                }
            } else {
                DispatchQueue.main.async {
                    self.editIcon.image = UIImage(named: "edit_icon")
                    self.editButton.backgroundColor = CustomUIColor.turquoise
                    self.editButton.layer.borderWidth = 0.0
                }
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "友達"
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
        
        self.displayFriendList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.displayFriendList()
    }
    
    private func displayFriendList() {
        self.friendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let friendList = UserDefaults.standard.object(forKey: UserDefaultKeys.friendList) as? [String : String] {
            for friendUniqueKey in friendList.keys {
                let friendCardView = FriendCardView()
                friendCardView.uniqueKey = friendUniqueKey
                friendCardView.displayName = friendList[friendUniqueKey]
                
                // 削除ポップアップ処理をクロージャで渡しておく
                friendCardView.deleteAlertAcrion = {
                    DispatchQueue.main.async {
                        self.present(friendCardView.alertController, animated: true)
                    }
                }
                
                // 削除処理をクロージャで渡しておく
                friendCardView.deleteAction = {
                    for arrangedSubviews in self.friendStackView.arrangedSubviews {
                        if
                            let friendCard = arrangedSubviews as? FriendCardView,
                            friendCard.uniqueKey == friendUniqueKey
                        {
                            DispatchQueue.main.async {
                                friendCard.removeFromSuperview()
                            }
                        }
                    }
                }
                
                let profileKey = friendUniqueKey + "_profile"
                
                if
                    let archivedUserInfo = UserDefaults.standard.object(forKey: profileKey) as? Data,
                    let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedUserInfo) as? UserInfo
                {
                    friendCardView.userInfo = userInfo
                }
                
                self.friendStackView.addArrangedSubview(friendCardView)
                friendCardView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
                friendCardView.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
                
                friendCardView.addTarget(self, action: #selector(self.tappedFriendCard(_:)), for: .touchUpInside)
            }
        }
    }

    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.friendStackView)
        self.view.addSubview(self.editButton)
        self.editButton.addSubview(self.editIcon)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "お気に入りを交換した友達"
        
        self.editButton.addTarget(self, action: #selector(self.tappedEditButton), for: .touchUpInside)
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 20.0
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = .boldSystemFont(ofSize: 15.0)
        
        self.editButton.backgroundColor = CustomUIColor.turquoise
        self.editButton.layer.cornerRadius = 25.0
        self.editButton.clipsToBounds = true
        
        self.editIcon.isUserInteractionEnabled = false
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 30.0)
        self.friendStackView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
        
        self.editButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.editButton.autoPinEdge(
            toSuperviewEdge: .bottom, withInset: TabBarHeightManager.shared.height + 50.0
        )
        self.editButton.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))
        
        self.editIcon.autoCenterInSuperview()
    }
    
    @objc private func tappedFriendCard(_ sender: FriendCardView) {
        if
            let unwrappedUniqueKey = sender.uniqueKey,
            let unwrappedDisplayName = sender.displayName
        {
            self.present(
                FriendDetailViewController(
                    uniqueKey: unwrappedUniqueKey,
                    displayName: unwrappedDisplayName,
                    userInfo: sender.userInfo
                ),
                animated: true
            )
        } else {
            Toast.show("現在ご利用できません", self.view)
        }
    }
    
    @objc private func tappedEditButton() {
        // ハプティックフィードバックを入れる
//        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        for arrangedSubviews in self.friendStackView.arrangedSubviews {
            if let friendCard = arrangedSubviews as? FriendCardView {
                friendCard.isHideDeleteButton = self.isEditMode
            }
        }
        
        self.isEditMode.toggle()
    }
}
