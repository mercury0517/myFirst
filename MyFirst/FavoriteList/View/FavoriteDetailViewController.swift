import UIKit

class FavoriteDetailViewController: UIViewController {
    let categoryName: String
    let itemIndex: Int
    let favorite: MyFavorite
    let presenter: FavoriteListPresenterProtocol
    
    var alertController = UIAlertController(
        title: "Delete your favorite?", message: nil, preferredStyle: .alert
    )
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    let closeButton = UIControl()
    let closeIcon = UIImageView(image: UIImage(named: "close"))
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    let deleteButton = UIButton()
    
    let editButton = UIControl()
    let editIcon = UIImageView(image: UIImage(named: "edit_icon"))
    
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
        
        self.customDeleteFavoriteAlert()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.itemImageView)
        self.scrollView.addSubview(self.closeButton)
        self.closeButton.addSubview(self.closeIcon)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.detailLabel)
        self.scrollView.addSubview(self.deleteButton)
        self.view.addSubview(self.editButton)
        self.editButton.addSubview(self.editIcon)
    }
    
    private func configSubViews() {
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        self.itemImageView.image = self.favorite.image
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        self.closeIcon.isUserInteractionEnabled = false
        
        self.titleLabel.text = self.favorite.title
        self.titleLabel.numberOfLines = 2
        
        self.detailLabel.text = self.favorite.memo
        self.detailLabel.numberOfLines = 0
        
        self.deleteButton.setTitle("DELETE ITEM", for: .normal)
        self.deleteButton.addTarget(self, action: #selector(self.tappedDeleteButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.font = UIFont(name: "Oswald", size: 25.0)
        self.titleLabel.textColor = .black
        
        self.detailLabel.font = .systemFont(ofSize: 15.0)
        self.detailLabel.textColor = .black
        
        self.editButton.backgroundColor = CustomUIColor.turquoise
        self.editButton.layer.cornerRadius = 25.0
        self.editButton.clipsToBounds = true
        self.editButton.addTarget(self, action: #selector(self.tappedEditButton), for: .touchUpInside)
        
        self.editIcon.isUserInteractionEnabled = false
        
        self.deleteButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.deleteButton.setTitleColor(.red, for: .normal)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 300.0))
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)

        self.closeIcon.autoPinEdgesToSuperviewEdges()
        self.closeIcon.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.itemImageView, withOffset: 20.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.detailLabel.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 10.0)
        self.detailLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.detailLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.deleteButton.autoPinEdge(.top, to: .bottom, of: self.detailLabel, withOffset: 20.0)
        self.deleteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.deleteButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
        
        self.editButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.editButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30.0)
        self.editButton.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))
        
        self.editIcon.autoCenterInSuperview()
    }
    
    private func customDeleteFavoriteAlert() {
        let albumAction = UIAlertAction(title: "DELETE", style: .destructive) { (action) in
            self.presenter.deleteItemButtonDidTap(
                categoryName: self.categoryName, itemIndex: self.itemIndex, detailView: self
            )
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: nil)
        }
        
        self.alertController.addAction(albumAction)
        self.alertController.addAction(cancelAction)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func tappedDeleteButton() {
        self.present(self.alertController, animated: true)
    }
    
    @objc private func tappedEditButton() {
        print("コッコ")
        print(self.favorite.index)
        
        self.presenter.editItemButtonDidTap(favorite: self.favorite)
    }
}
