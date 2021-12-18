import UIKit

class FavoriteDetailViewController: UIViewController {
    let categoryName: String
    let itemIndex: Int
    let favorite: MyFavorite
    let presenter: FavoriteListPresenterProtocol
    
    let itemImageView = UIImageView()
    
    let titleLabel = UILabel()
    
    init(
        categoryName: String,
        itemIndex: Int,
        favorite: MyFavorite,
        presenter: FavoriteListPresenterProtocol
    ) {
        self.categoryName = categoryName
        self.itemIndex = itemIndex
        self.favorite = favorite
        self.presenter = presenter
        
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
        self.view.addSubview(self.itemImageView)
        self.view.addSubview(self.titleLabel)
    }
    
    private func configSubViews() {
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        self.itemImageView.image = self.favorite.image
        
        self.titleLabel.text = self.favorite.title
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.font = UIFont(name: "Oswald", size: 25.0)
        self.titleLabel.textColor = .black
    }
    
    private func addConstraints() {
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimension(.height, toSize: 200.0)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.itemImageView, withOffset: 20.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
    }
}
