import UIKit

class FavoriteDetailViewController: UIViewController {
    let categoryName: String
    let itemIndex: Int
    let favorite: MyFavorite
    let presenter: FavoriteListPresenterProtocol
    
    let imageHeight = UIScreen.main.bounds.height * 0.4
    
    var alertController = UIAlertController(
        title: "お気に入りを削除しますか？", message: nil, preferredStyle: .alert
    )
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIImage(named: "sky"))
    let closeButton = CustomCloseButton()
    
    let titleLabel = CustomUILabel()
    let detailLabel = CustomUILabel()
    let twiiterButton = UIButton()
    
    let deleteButton = UIControl()
    let deleteIcon = UIImageView(image: UIImage(named: "delete_icon"))
    
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
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.detailLabel)
        self.scrollView.addSubview(self.twiiterButton)
        self.view.addSubview(self.deleteButton)
        self.deleteButton.addSubview(self.deleteIcon)
        self.view.addSubview(self.editButton)
        self.editButton.addSubview(self.editIcon)
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
        
        self.twiiterButton.setImage(UIImage(named: "twitter"), for: .normal)
        self.twiiterButton.addTarget(self, action: #selector(self.tappedTwitterButton), for: .touchUpInside)
        
        self.deleteButton.addTarget(self, action: #selector(self.tappedDeleteButton), for: .touchUpInside)
        
        self.editButton.addTarget(self, action: #selector(self.tappedEditButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.font = UIFont(name: "Oswald", size: 25.0)
        self.titleLabel.textColor = .black
        
        self.detailLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.detailLabel.textColor = .black
        
        self.twiiterButton.backgroundColor = .yellow
        
        self.deleteButton.backgroundColor = .white
        self.deleteButton.layer.cornerRadius = 25.0
        self.deleteButton.clipsToBounds = true
        self.deleteButton.layer.borderColor = UIColor.red.cgColor
        self.deleteButton.layer.borderWidth = 1.0
        
        self.deleteIcon.isUserInteractionEnabled = false
        
        self.editButton.backgroundColor = CustomUIColor.turquoise
        self.editButton.layer.cornerRadius = 25.0
        self.editButton.clipsToBounds = true
        
        self.editIcon.isUserInteractionEnabled = false
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
        
        self.twiiterButton.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        self.twiiterButton.autoAlignAxis(.horizontal, toSameAxisOf: self.titleLabel)
        self.twiiterButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.deleteButton.autoPinEdge(.right, to: .left, of: self.editButton, withOffset: -10.0)
        self.deleteButton.autoAlignAxis(.horizontal, toSameAxisOf: self.editButton)
        self.deleteButton.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))
        
        self.deleteIcon.autoCenterInSuperview()
        
        self.editButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.editButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30.0)
        self.editButton.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))
        
        self.editIcon.autoCenterInSuperview()
    }
    
    private func customDeleteFavoriteAlert() {
        let albumAction = UIAlertAction(title: "削除する", style: .destructive) { (action) in
            self.presenter.deleteItemButtonDidTap(
                categoryName: self.categoryName, itemIndex: self.itemIndex, detailView: self
            )
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: nil)
        }
        
        self.alertController.addAction(albumAction)
        self.alertController.addAction(cancelAction)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    // MARK: share with Twitter
    @objc private func tappedTwitterButton() {
        if
            let titleText = self.titleLabel.text,
            let detailText = self.detailLabel.text
        {
            let text = titleText + "\n" +  detailText
            let hashTag = "#私のお気に入り #DIGIT #ディグイット"
            let completedText = text + "\n" + hashTag
            
            //作成したテキストをエンコード
            let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            //エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
            if let encodedText = encodedText,
               let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc private func tappedDeleteButton() {
        self.present(self.alertController, animated: true)
    }
    
    @objc private func tappedEditButton() {
        self.presenter.editItemButtonDidTap(favorite: self.favorite)
    }
}
