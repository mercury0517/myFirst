import UIKit

// 友達のアイテムの詳細画面
class FriendItemDetailViewController: UIViewController {
    let favorite: MyFavorite
    
    let imageHeight = UIScreen.main.bounds.height * 0.4
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIImage(named: "sky"))
    let closeButton = CustomCloseButton()
    
    let titleLabel = CustomUILabel()
    let detailLabel = CustomUILabel()
    
    init(favorite: MyFavorite) {
        self.favorite = favorite
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.itemImageView)
        self.scrollView.addSubview(self.closeButton)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.detailLabel)
    }
    
    private func configSubViews() {
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        self.itemImageView.image = self.favorite.image
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.titleLabel.text = self.favorite.title
        self.titleLabel.numberOfLines = 2
        
        self.detailLabel.text = self.favorite.memo
        self.detailLabel.numberOfLines = 0
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.font = UIFont(name: "Oswald", size: 25.0)
        self.titleLabel.textColor = .black
        
        self.detailLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.detailLabel.textColor = .black
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: self.imageHeight))
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.itemImageView, withOffset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.detailLabel.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 10.0)
        self.detailLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.detailLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.detailLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}
