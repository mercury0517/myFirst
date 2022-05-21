import UIKit
import PureLayout
import SimpleImageViewer
import GoogleMobileAds
import GoogleUtilities
import AdSupport
import AppTrackingTransparency

/*
 ホームのお気に入り画面
*/

class FavoriteListViewController: UIViewController, FavoriteListViewControllerProtocol {
    var presenter: FavoriteListPresenterProtocol?
    
    let imageHeight = UIScreen.main.bounds.height * 0.2
    
    var alertController = UIAlertController(
        title: "画像を選択する", message: nil, preferredStyle: .actionSheet
    )
    
    let scrollView = UIScrollView()
    
    let scrollInnerView = UIView() // キャプチャ用にインナーを用意する
    
    let topBannerContainer = UIControl()
    let topBanner = UIImageView(image: UIImage(named: "scopp"))
    
    let userIconContainer = UIControl()
    let userIcon = UIImageView(image: UIImage(named: "scopp"))
    
    let cameraButton = UIControl()
    let cameraIcon = UIImageView(image: UIImage(named: "camera"))
    
    let editProfileButton = UIButton()
    let userNameLabel = UILabel()
    
    let separateLine = UIView()
    
    let hintButton = UIControl()
    let hintIcon = UIImageView(image: UIImage(named: "help"))
    
    let favoriteGroupStackView = UIStackView()
    
    var googleBannerView: GADBannerView!
    
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
        
        // 広告バナーの初期化
        self.googleBannerView = GADBannerView(adSize: GADAdSizeBanner)
        
        // 初回だけチュートリアルを出す
        if !UserDefaults.standard.bool(forKey: UserDefaultKeys.isAlredayDisplayTutorial) {
            let tutorialView = FavoriteTutorialViewController()
            tutorialView.modalPresentationStyle = .overFullScreen
            
            self.present(tutorialView, animated: true)
            
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.isAlredayDisplayTutorial)
        }
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        self.displayFavoriteGroupList()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ATTダイアログの表示
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("😭拒否")
            case .restricted:
                print("🥺制限")
            case .notDetermined:
                self.showRequestTrackingAuthorizationAlert()
            @unknown default:
                fatalError()
            }
        } else { // iOS14未満
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            } else {
                print("🥺制限")
            }
        }
    }
    
    ///Alert表示
    private func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    print("🎉")
                    //IDFA取得
                    print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                case .denied, .restricted, .notDetermined:
                    print("😭")
                @unknown default:
                    fatalError()
                }
            })
        }
    }
    
    // タブをタップした時に一番上に戻る
    func scrollToTop() {
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let margin = statusBarHeight + navigationBarHeight
        
        self.scrollView.setContentOffset(
            CGPoint(x: 0, y: 0 - self.scrollView.contentInset.top - margin),
            animated: true
        )
    }
    
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func dismissToHome() {
        self.dismiss(animated: true)
    }
    
    func updateFavoriteList() {
        if
            let data = UserDefaults.standard.object(forKey: UserDefaultKeys.userInfo) as? Data,
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo
        {
            self.topBanner.image = userInfo.topBanner
            self.userIcon.image = userInfo.icon
            self.userNameLabel.text = userInfo.name
        } else {
            self.topBanner.image = UIImage(named: "scopp")
            self.userIcon.image = UIImage(named: "scopp")
            self.userNameLabel.text = "名称未設定"
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
        self.scrollView.addSubview(self.scrollInnerView)
        self.scrollInnerView.addSubview(self.topBannerContainer)
        self.topBannerContainer.addSubview(self.topBanner)
        self.scrollInnerView.addSubview(self.userIconContainer)
        self.userIconContainer.addSubview(self.userIcon)
        self.scrollInnerView.addSubview(self.editProfileButton)
        self.scrollInnerView.addSubview(self.cameraButton)
        self.cameraButton.addSubview(self.cameraIcon)
        self.scrollInnerView.addSubview(self.userNameLabel)
        self.scrollInnerView.addSubview(self.separateLine)
        self.scrollInnerView.addSubview(self.hintButton)
        self.hintButton.addSubview(self.hintIcon)
        self.scrollInnerView.addSubview(self.favoriteGroupStackView)
        self.view.addSubview(self.googleBannerView)
    }
    
    private func configSubViews() {
        self.scrollView.showsVerticalScrollIndicator = false
        
        if
            let data = UserDefaults.standard.object(forKey: UserDefaultKeys.userInfo) as? Data,
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo
        {
            self.topBanner.image = userInfo.topBanner
            self.userIcon.image = userInfo.icon
            self.userNameLabel.text = userInfo.name
        } else {
            self.userNameLabel.text = ""
        }
        
        self.customPhotoLibraryAlert()
        
        self.editProfileButton.setTitle("EDIT PROFILE", for: .normal)
        self.editProfileButton.addTarget(self, action: #selector(self.tappedEditProfileButton), for: .touchUpInside)
        
        self.cameraButton.addTarget(self, action: #selector(self.tappedScreenShotButton), for: .touchUpInside)
        
        self.cameraIcon.isUserInteractionEnabled = false

        // バナータップ時
        self.topBannerContainer.addTarget(self, action: #selector(self.tappedBanner), for: .touchUpInside)
        
        self.topBanner.backgroundColor = .black
        self.topBanner.contentMode = .scaleAspectFill
        self.topBanner.clipsToBounds = true
        
        // アイコンタップ時
        self.userIconContainer.addTarget(self, action: #selector(self.tappedUserIcon), for: .touchUpInside)
        
        self.userIcon.layer.cornerRadius = 50.0
        self.userIcon.contentMode = .scaleAspectFill
        self.userIcon.clipsToBounds = true
        self.userIcon.layer.borderWidth = 3.0
        self.userIcon.layer.borderColor = UIColor.white.cgColor
        
        self.hintButton.addTarget(self, action: #selector(self.tappedHintButton), for: .touchUpInside)
        
        self.favoriteGroupStackView.alignment = .center
        self.favoriteGroupStackView.axis = .vertical
        self.favoriteGroupStackView.spacing = 20.0

        // 広告バナーの表示
        if let id = adUnitID(key: "banner") {
            self.googleBannerView.adUnitID = id
            self.googleBannerView.rootViewController = self
            self.googleBannerView.load(GADRequest())
        }
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.editProfileButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.editProfileButton.backgroundColor = CustomUIColor.turquoise
        self.editProfileButton.contentEdgeInsets = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)
        self.editProfileButton.layer.cornerRadius = 5.0
        
        self.cameraButton.backgroundColor = .white
        
        self.userNameLabel.textColor = .black
        self.userNameLabel.font = UIFont(name: "Oswald", size: 25.0)
        
        self.separateLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        
        self.hintButton.layer.cornerRadius = 10.0
        self.hintButton.clipsToBounds = true
        
        self.hintIcon.isUserInteractionEnabled = false
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.scrollInnerView.autoPinEdgesToSuperviewEdges()
        
        // バナーをステータスバーに重ねる為に、画像を上にずらす
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let topMargin = (statusBarHeight + navigationBarHeight) * -1
        
        self.topBannerContainer.autoPinEdge(toSuperviewEdge: .top, withInset: topMargin)
        self.topBannerContainer.autoPinEdge(toSuperviewEdge: .left)
        self.topBannerContainer.autoPinEdge(toSuperviewEdge: .right)
        self.topBannerContainer.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: self.imageHeight))
        
        self.topBanner.autoPinEdgesToSuperviewEdges()
        
        self.userIconContainer.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: -50.0)
        self.userIconContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.userIcon.autoPinEdgesToSuperviewEdges()
        self.userIcon.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        
        self.editProfileButton.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: 20.0)
        self.editProfileButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.cameraButton.autoAlignAxis(.horizontal, toSameAxisOf: self.editProfileButton)
        self.cameraButton.autoPinEdge(.right, to: .left, of: self.editProfileButton, withOffset: -20.0)
        self.cameraButton.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        
        self.cameraIcon.autoPinEdgesToSuperviewEdges()
        
        self.userNameLabel.autoPinEdge(.top, to: .bottom, of: self.userIconContainer, withOffset: 10.0)
        self.userNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.separateLine.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 1.0))
        self.separateLine.autoPinEdge(.top, to: .bottom, of: self.userNameLabel, withOffset: 20.0)
        self.separateLine.autoPinEdge(toSuperviewEdge: .left)
        self.separateLine.autoPinEdge(toSuperviewEdge: .right)
        
        self.hintButton.autoPinEdge(.top, to: .bottom, of: self.separateLine, withOffset: 10.0)
        self.hintButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.hintButton.autoSetDimensions(to: CGSize(width: 20.0, height: 20.0))
        
        self.hintIcon.autoPinEdgesToSuperviewEdges()
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.hintButton, withOffset: 5.0)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .right)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
        
        self.googleBannerView.autoSetDimensions(to: CGSize(width: 320.0, height: 50.0))
        self.googleBannerView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.googleBannerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
    }
    
    private func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
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
    
    private func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.scrollInnerView.frame.size, false, 0.0)

        self.scrollInnerView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
    @objc private func tappedTopBanner() {
        // バナーの拡大表示
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self.userIcon
        }

        let imageViewerController = ImageViewerController(configuration: configuration)

        self.present(imageViewerController, animated: true)
    }
    
    @objc private func tappedBanner() {
        // バナーの拡大表示
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self.topBanner
        }

        let imageViewerController = ImageViewerController(configuration: configuration)

        self.present(imageViewerController, animated: true)
    }
    
    @objc private func tappedUserIcon() {
        // アイコンの拡大表示
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self.userIcon
        }

        let imageViewerController = ImageViewerController(configuration: configuration)

        self.present(imageViewerController, animated: true)
    }
    
    @objc private func tappedScreenShotButton() {
        // 連続タップを防ぐ
        self.cameraButton.isEnabled = false
        
        if let image = self.snapshot() {            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            // スクショ撮れたよトーストか画面を出す
            DispatchQueue.main.async {
                let shareBottomSheet = CustomFloatingViewController()
                
                // TODO: 透過するとシートが大きくなってしまうので、詳しく調べる
//                let blurEffect = UIBlurEffect(style: .regular)
//                let blurEffectView = UIVisualEffectView(effect: blurEffect)
//                blurEffectView.frame = shareBottomSheet.view.frame
//                shareBottomSheet.view.addSubview(blurEffectView)
                
                self.present(shareBottomSheet)
            }
            
            self.cameraButton.isEnabled = true
        }
    }
    
    @objc private func tappedEditProfileButton() {
        self.presenter?.editProfileButtonDidTap(
            userName: self.userNameLabel.text ?? "", userIcon: self.userIcon.image, topBanner: self.topBanner.image
        )
    }
    
    @objc private func tappedHintButton() {
        let tutorialView = FavoriteTutorialViewController()
        tutorialView.modalPresentationStyle = .overFullScreen
        
        self.present(tutorialView, animated: true)
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
