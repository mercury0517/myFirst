import UIKit

class FriendListViewController: UIViewController {
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    let friendStackView = UIStackView()
    
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
                let friendCardView = FriendView()
                friendCardView.uniqueKey = friendUniqueKey
                friendCardView.displayName = friendList[friendUniqueKey]
                
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
    }
    
    private func configSubViews() {
        self.titleLabel.text = "お気に入りを交換した友達"
        
        self.friendStackView.alignment = .center
        self.friendStackView.axis = .vertical
        self.friendStackView.spacing = 10.0
    }
    
    private func applyStyling() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 15.0)
        
        self.view.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.friendStackView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 10.0)
        self.friendStackView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        self.friendStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
    }
    
    @objc private func tappedFriendCard(_ sender: FriendView) {
        if
            let unwrappedUniqueKey = sender.uniqueKey,
            let unwrappedDisplayName = sender.displayName
        {
            self.present(
                CustomNavigationController(
                    rootViewController: FriendDetailViewController(
                        uniqueKey: unwrappedUniqueKey,
                        displayName: unwrappedDisplayName
                    )
                ),
                animated: true
            )
        } else {
            Toast.show("現在ご利用できません", self.view)
        }
    }
}
