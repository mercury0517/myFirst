import AudioToolbox
import UIKit

class FriendListViewController: UIViewController {
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    
    let editButton = UIControl()
    let editIcon = UIImageView(image: UIImage(named: "edit_icon"))
    
    let friendStackView = UIStackView()
    
    let emptyImage = UIImageView(image: UIImage(named: "friend_empty"))
    let emptyLabel = UILabel()
    
    var isEditMode: Bool = false {
        didSet {
            if self.isEditMode {
                DispatchQueue.main.async {
                    self.editIcon.image = UIImage(named: "return")
                    self.editButton.backgroundColor = .white
                    self.editButton.layer.borderColor = CustomUIColor.turquoise.cgColor
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
        
        self.navigationItem.title = "Friend"
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
                                
                                self.displayEmptyMassageIfNeeded()
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
        
        self.displayEmptyMassageIfNeeded()
    }
    
    private func displayEmptyMassageIfNeeded() {
        if self.friendStackView.arrangedSubviews.isEmpty {
            self.editButton.isHidden = true
            
            self.friendStackView.addArrangedSubview(self.emptyImage)
            self.emptyImage.autoAlignAxis(toSuperviewAxis: .vertical)
            self.emptyImage.autoSetDimension(.width, toSize: 100.0)
            self.emptyImage.contentMode = .scaleAspectFit
            
            self.friendStackView.addArrangedSubview(self.emptyLabel)
            self.emptyLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
            self.emptyLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
            
            self.friendStackView.setCustomSpacing(0.0, after: self.emptyImage)
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
        self.titleLabel.text = "Your friends"
        
        self.editButton.addTarget(self, action: #selector(self.tappedEditButton), for: .touchUpInside)
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 15.0
        
        self.emptyLabel.text = "You haven't exchanged your favorites yet. \nShare your favorites with friends near you!"
        self.emptyLabel.numberOfLines = 0
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 18.0)
        
        self.editButton.backgroundColor = CustomUIColor.turquoise
        self.editButton.layer.cornerRadius = 25.0
        self.editButton.clipsToBounds = true
        
        self.editIcon.isUserInteractionEnabled = false
        
        self.emptyLabel.textColor = .black
        self.emptyLabel.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 10.0)
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
            Toast.show("Currently unavailable", self.view)
        }
    }
    
    @objc private func tappedEditButton() {
        // ハプティックフィードバックを入れる
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        for arrangedSubviews in self.friendStackView.arrangedSubviews {
            if let friendCard = arrangedSubviews as? FriendCardView {
                friendCard.isHideDeleteButton = self.isEditMode
            }
        }
        
        self.isEditMode.toggle()
    }
}
