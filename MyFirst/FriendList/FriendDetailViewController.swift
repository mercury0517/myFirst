import UIKit
import SimpleImageViewer

class FriendDetailViewController: UIViewController {
    let uniqueKey: String
    let displayName: String
    var userInfo: UserInfo?
    
    let imageHeight = UIScreen.main.bounds.height * 0.15
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIImage(named: "sky"))
    let closeButton = CustomCloseButton()
    
    let userIconContainer = UIControl()
    let userIconView = UIImageView(image: UIImage(named: "sky"))
    
    let userNameLabel = UILabel()
    let separateLine = UIView()
    
    let favoriteGroupStackView = UIStackView()
    
    init(uniqueKey: String, displayName: String, userInfo: UserInfo?) {
        self.uniqueKey = uniqueKey
        self.displayName = displayName
        self.userInfo = userInfo
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.uniqueKey = ""
        self.displayName = ""
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        self.displayFavoriteList()
        
        self.navigationItem.title = "\(self.displayName)"
    }
    
    func displayItemDetailView(favorite: MyFavorite) {
        self.present(
            FriendItemDetailViewController(favorite: favorite),
            animated: true
        )
    }
    
    private func displayFavoriteList() {
        // キャッシュからお気に入りを取り出して表示する
        if
            let archivedFavoriteList = UserDefaults.standard.object(forKey: self.uniqueKey) as? Data,
            let favoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedFavoriteList) as? [MyFavorite]
        {
            let favoriteGroupView = FriendFavoriteGroupView(favoriteList: favoriteList, view: self)
        
            self.favoriteGroupStackView.addArrangedSubview(favoriteGroupView)
            favoriteGroupView.autoPinEdgesToSuperviewEdges()
        }
    }

    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.itemImageView)
        self.scrollView.addSubview(self.closeButton)
        self.scrollView.addSubview(self.userIconContainer)
        self.userIconContainer.addSubview(self.userIconView)
        self.scrollView.addSubview(self.userNameLabel)
        self.scrollView.addSubview(self.separateLine)
        self.scrollView.addSubview(self.favoriteGroupStackView)
    }
    
    private func configSubViews() {
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        self.itemImageView.image = self.userInfo?.topBanner ?? UIImage(named: "sky")
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.userIconView.layer.cornerRadius = 50.0
        self.userIconView.contentMode = .scaleAspectFill
        self.userIconView.clipsToBounds = true
        self.userIconView.layer.borderWidth = 3.0
        self.userIconView.layer.borderColor = UIColor.white.cgColor
        self.userIconView.image = self.userInfo?.icon ?? UIImage(named: "sky")
        
        self.userNameLabel.text = self.userInfo?.name ?? "名称未設定"
        
        self.favoriteGroupStackView.axis = .vertical
        self.favoriteGroupStackView.spacing = 0.0
        self.favoriteGroupStackView.alignment = .center
        
        // アイコンタップ時
        self.userIconContainer.addTarget(self, action: #selector(self.tappedUserIcon), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.userNameLabel.font = UIFont(name: "Oswald", size: 25.0)
        self.userNameLabel.textColor = .black
        
        self.separateLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: self.imageHeight))
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.userIconContainer.autoPinEdge(.top, to: .bottom, of: self.itemImageView, withOffset: -50.0)
        self.userIconContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.userIconView.autoPinEdgesToSuperviewEdges()
        self.userIconView.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        
        self.userNameLabel.autoPinEdge(.top, to: .bottom, of: self.userIconView, withOffset: 10.0)
        self.userNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.separateLine.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 1.0))
        self.separateLine.autoPinEdge(.top, to: .bottom, of: self.userNameLabel, withOffset: 20.0)
        self.separateLine.autoPinEdge(toSuperviewEdge: .left)
        self.separateLine.autoPinEdge(toSuperviewEdge: .right)
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.separateLine, withOffset: 40.0)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .right)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40.0)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func tappedUserIcon() {
        // アイコンの拡大表示
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self.userIconView
        }

        let imageViewerController = ImageViewerController(configuration: configuration)

        self.present(imageViewerController, animated: true)
    }
}
