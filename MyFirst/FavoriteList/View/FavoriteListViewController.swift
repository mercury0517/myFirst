import UIKit
import PureLayout

/*
 TODO3: 新規カテゴリを追加できる様にする
 TODO4: 既存カテゴリを編集できる様にする
*/
class FavoriteListViewController: UIViewController, FavoriteListViewControllerProtocol {
    var presenter: FavoriteListPresenterProtocol?
    
    let imageHeight = UIScreen.main.bounds.height * 0.2
    
    var alertController = UIAlertController(
        title: "画像を選択する", message: nil, preferredStyle: .actionSheet
    )
    
    let scrollView = UIScrollView()
    
    let topBanner = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    
    let userIconContainer = UIControl()
    let userIcon = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    
    let editProfileButton = UIButton()
    let userNameLabel = UILabel()
    
    let separateLine = UIView()
    
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
    
    func dismissToHome() {
        self.dismiss(animated: true)
    }
    
    func updateFavoriteList() {
        if
            let data = UserDefaults.standard.object(forKey: "userInfo") as? Data,
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo
        {
            self.topBanner.image = userInfo.topBanner
            self.userIcon.image = userInfo.icon
            self.userNameLabel.text = userInfo.name
        } else {
            self.topBanner.image = UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0))
            self.userIcon.image = UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0))
            self.userNameLabel.text = ""
        }
        
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
        self.scrollView.addSubview(self.userIconContainer)
        self.userIconContainer.addSubview(self.userIcon)
        self.scrollView.addSubview(self.editProfileButton)
        self.scrollView.addSubview(self.userNameLabel)
        self.scrollView.addSubview(self.separateLine)
        self.scrollView.addSubview(self.favoriteGroupStackView)
    }
    
    private func configSubViews() {
        self.scrollView.showsVerticalScrollIndicator = false
        
        if
            let data = UserDefaults.standard.object(forKey: "userInfo") as? Data,
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo
        {
            self.topBanner.image = userInfo.topBanner
            self.userIcon.image = userInfo.icon
            self.userNameLabel.text = userInfo.name
        } else {
            self.userNameLabel.text = "YOUR NAME"
        }
        
        self.customPhotoLibraryAlert()
        
        
        self.editProfileButton.setTitle("プロフィール編集", for: .normal)
        self.editProfileButton.addTarget(self, action: #selector(self.tappedEditProfileButton), for: .touchUpInside)

        self.topBanner.backgroundColor = .black
        self.topBanner.contentMode = .scaleAspectFill
        self.topBanner.clipsToBounds = true
        
        self.userIcon.layer.cornerRadius = 50.0
        self.userIcon.contentMode = .scaleAspectFill
        self.userIcon.clipsToBounds = true
        self.userIcon.layer.borderWidth = 3.0
        self.userIcon.layer.borderColor = UIColor.white.cgColor
        
        self.favoriteGroupStackView.alignment = .center
        self.favoriteGroupStackView.axis = .vertical
        self.favoriteGroupStackView.spacing = 20.0
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.editProfileButton.titleLabel?.font = UIFont(name: "Oswald", size: 12.0)
        self.editProfileButton.backgroundColor = CustomUIColor.turquoise
        self.editProfileButton.contentEdgeInsets = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)
        self.editProfileButton.layer.cornerRadius = 5.0
        
        self.userNameLabel.textColor = .black
        self.userNameLabel.font = UIFont(name: "Oswald", size: 25.0)
        
        self.separateLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
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
        self.topBanner.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: self.imageHeight))
        
        self.userIconContainer.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: -50.0)
        self.userIconContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.userIcon.autoPinEdgesToSuperviewEdges()
        self.userIcon.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        
        self.editProfileButton.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: 20.0)
        self.editProfileButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.userNameLabel.autoPinEdge(.top, to: .bottom, of: self.userIconContainer, withOffset: 10.0)
        self.userNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.separateLine.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 1.0))
        self.separateLine.autoPinEdge(.top, to: .bottom, of: self.userNameLabel, withOffset: 20.0)
        self.separateLine.autoPinEdge(toSuperviewEdge: .left)
        self.separateLine.autoPinEdge(toSuperviewEdge: .right)
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.separateLine, withOffset: 20.0)
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
                Toast.show("フォトライブラリは現在利用できません。", self.view)
            }
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: nil)
        }
        
        self.alertController.addAction(albumAction)
        self.alertController.addAction(cancelAction)
    }
    
    @objc private func tappedEditProfileButton() {
        self.presenter?.editProfileButtonDidTap(
            userName: self.userNameLabel.text ?? "", userIcon: self.userIcon.image, topBanner: self.topBanner.image
        )
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

