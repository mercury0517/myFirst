import UIKit
import PureLayout

/*
 TODO3: 新規カテゴリを追加できる様にする
 TODO4: 既存カテゴリを編集できる様にする
*/
class FavoriteListViewController: UIViewController, FavoriteListViewControllerProtocol {
    var presenter: FavoriteListPresenterProtocol?
    
    var alertController = UIAlertController(
        title: "Please select image", message: nil, preferredStyle: .actionSheet
    )
    
    let scrollView = UIScrollView()
    
    let topBanner = UIImageView(image: UIImage(named: "flight_banner"))
    let userNameLabel = UILabel()
    let editTopBannerButton = UIButton()
    
    let favoriteGroupStackView = UIStackView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
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
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
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
        self.scrollView.addSubview(self.topBanner)
        self.scrollView.addSubview(self.userNameLabel)
        self.scrollView.addSubview(self.editTopBannerButton)
        self.scrollView.addSubview(self.favoriteGroupStackView)
    }
    
    private func configSubViews() {
        self.customPhotoLibraryAlert()
        
        self.userNameLabel.text = "AKIHIRO IHARA"
        
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
        self.favoriteGroupStackView.spacing = 20.0
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.userNameLabel.textColor = .black
        self.userNameLabel.font = UIFont(name: "Oswald", size: 25.0)
        
        self.editTopBannerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.editTopBannerButton.backgroundColor = CustomUIColor.turquoise
        self.editTopBannerButton.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        self.editTopBannerButton.layer.cornerRadius = 5.0
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        // バナーをステータスバーに重ねる為に、画像を上にずらす
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let topMargin = (statusBarHeight + navigationBarHeight) * -1
        
        self.topBanner.autoPinEdge(toSuperviewEdge: .top, withInset: topMargin)
        self.topBanner.autoPinEdge(toSuperviewEdge: .left)
        self.topBanner.autoPinEdge(toSuperviewEdge: .right)
        self.topBanner.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 250.0))
        
        self.userNameLabel.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: 10.0)
        self.userNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.editTopBannerButton.autoAlignAxis(.horizontal, toSameAxisOf: self.userNameLabel)
        self.editTopBannerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.userNameLabel, withOffset: 50.0)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .right)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
    }
    
    private func customPhotoLibraryAlert() {
        let albumAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("The photo library is not available on this device")
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

