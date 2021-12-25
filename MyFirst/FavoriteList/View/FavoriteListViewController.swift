import UIKit
import PureLayout

/*
 TODO3: 新規カテゴリを追加できる様にする
 TODO4: 既存カテゴリを編集できる様にする
 TODO5: 既存カテゴリの右に追加ボタンを置く、ただし1カテゴリ3個までしか登録させない
*/
class FavoriteListViewController: UIViewController, FavoriteListViewControllerProtocol {
    var presenter: FavoriteListPresenterProtocol?
    
    var alertController = UIAlertController(
        title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet
    )
    
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    let editTopBannerButton = UIButton()
    let topBanner = UIImageView(image: UIImage(named: "flight_banner"))
    let favoriteGroupStackView = UIStackView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        
        self.displayFavoriteGroupList()
    }
    
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func updateFavoriteList() {
        self.favoriteGroupStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for favoriteCategory in FavoriteCategory.allCases {
            let favoriteGroupView = FavoriteGroupView(title: favoriteCategory.rawValue, presenter: self.presenter)
            
            self.favoriteGroupStackView.addArrangedSubview(favoriteGroupView)
            
            favoriteGroupView.autoPinEdge(toSuperviewEdge: .left)
            favoriteGroupView.autoPinEdge(toSuperviewEdge: .right)
            
            favoriteGroupView.collectionView.reloadData()
        }
    }
    
    func displayFavoriteGroupList() {
        self.favoriteGroupStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for favoriteCategory in FavoriteCategory.allCases {
            let favoriteGroupView = FavoriteGroupView(title: favoriteCategory.rawValue, presenter: self.presenter)
            
            self.favoriteGroupStackView.addArrangedSubview(favoriteGroupView)
            
            favoriteGroupView.autoPinEdge(toSuperviewEdge: .left)
            favoriteGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.editTopBannerButton)
        self.scrollView.addSubview(self.topBanner)
        self.scrollView.addSubview(self.favoriteGroupStackView)
    }
    
    private func configSubViews() {
        self.customPhotoLibraryAlert()
        
        self.titleLabel.text = "MY FAVORITE"
        
        self.editTopBannerButton.setTitle("EDIT PROFILE", for: .normal)
        self.editTopBannerButton.addTarget(self, action: #selector(self.tappedEditTopBannerButton), for: .touchUpInside)

        self.topBanner.backgroundColor = .black
        self.topBanner.contentMode = .scaleAspectFill
        self.topBanner.clipsToBounds = true
        
        // 設定済みのTOPバナーをキャッシュから復元
        if let images = UserDefaults.standard.object(forKey: "bannerImage") as? NSArray {
            if images.count != 0 {
                let cachedImage = UIImage(data: images[0] as! Data)
                self.topBanner.image = cachedImage
            }
        }
        
        self.favoriteGroupStackView.alignment = .center
        self.favoriteGroupStackView.axis = .vertical
        self.favoriteGroupStackView.spacing = 10.0
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 20.0)
        
        self.editTopBannerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.editTopBannerButton.backgroundColor = CustomUIColor.turquoise
        self.editTopBannerButton.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        self.editTopBannerButton.layer.cornerRadius = 5.0
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 40.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.editTopBannerButton.autoAlignAxis(.horizontal, toSameAxisOf: self.titleLabel)
        self.editTopBannerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        
        self.topBanner.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 20.0)
        self.topBanner.autoPinEdge(toSuperviewEdge: .left)
        self.topBanner.autoPinEdge(toSuperviewEdge: .right)
        self.topBanner.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 250.0))
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: 20.0)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .right)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
    }
    
    private func customPhotoLibraryAlert() {
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではフォトライブラリが使用出来ません。")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: nil)
        }
        
        self.alertController.addAction(albumAction)
        self.alertController.addAction(cancelAction)
    }
    
    @objc private func tappedEditTopBannerButton() {
        self.presenter?.editTopBannerButtonDidTap()
    }
}

extension FavoriteListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.topBanner.image = selectedImage

        self.presenter?.bannerImageSelected(image: selectedImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
}

