import UIKit

class ProfileEditViewController: UIViewController {
    let userName: String
    let userIcon: UIImage?
    let topBanner: UIImage?
    let presenter: FavoriteListPresenterProtocol
    
    // フォトライブラリからの画像選択が2箇所あり、PickerViewの構造上、どちらの画像が選択しているか管理する必要がある
    var willSelectBannerImage: Bool = true
    
    var selectedBannerImage: UIImage? {
        didSet {
            self.itemImageView.image = self.selectedBannerImage
        }
    }
    
    var selectedUserIcon: UIImage? {
        didSet {
            self.userIconView.image = self.selectedUserIcon
        }
    }

    let itemImageViewContainer = UIControl()
    let itemImageView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    
    let closeButton = UIControl()
    let closeIcon = UIImageView(image: UIImage(named: "close"))
    
    let userIconContainer = UIControl()
    let userIconView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 100.0, height: 100.0)))
    
    let userNameTitleLabel = UILabel()
    let userNameTextField = CustomTextField()
    
    let registerButton = UIButton()
    
    init(userName: String, userIcon: UIImage?, topBanner: UIImage?, presenter: FavoriteListPresenterProtocol) {
        self.userName = userName
        self.userIcon = userIcon
        self.topBanner = topBanner
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
        self.view.addSubview(self.itemImageViewContainer)
        self.itemImageViewContainer.addSubview(self.itemImageView)
        self.view.addSubview(self.closeButton)
        self.closeButton.addSubview(self.closeIcon)
        self.view.addSubview(self.userIconContainer)
        self.userIconContainer.addSubview(self.userIconView)
        self.view.addSubview(self.userNameTitleLabel)
        self.view.addSubview(self.userNameTextField)
        self.view.addSubview(self.registerButton)
    }
    
    private func configSubViews() {
        self.itemImageViewContainer.addTarget(self, action: #selector(self.tappedBannerImage), for: .touchUpInside)
        
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        self.itemImageView.image = self.topBanner
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        self.closeIcon.isUserInteractionEnabled = false
        
        self.userIconContainer.addTarget(self, action: #selector(self.tappedUserIcon), for: .touchUpInside)
        
        self.userIconView.layer.cornerRadius = 50.0
        self.userIconView.contentMode = .scaleAspectFill
        self.userIconView.clipsToBounds = true
        self.userIconView.layer.borderWidth = 3.0
        self.userIconView.layer.borderColor = UIColor.white.cgColor
        self.userIconView.image = self.userIcon
        
        self.userNameTitleLabel.text = "YOUR NAME"

        self.userNameTextField.placeholder = "input your name"
        self.userNameTextField.text = self.userName
        
        self.registerButton.setTitle("REGISTER", for: .normal)
        self.registerButton.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.userNameTitleLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.userNameTitleLabel.textColor = .black
        
        self.registerButton.backgroundColor = CustomUIColor.turquoise
        self.registerButton.layer.cornerRadius = 5.0
        self.registerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.itemImageViewContainer.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageViewContainer.autoSetDimension(.height, toSize: 200.0)
        
        self.itemImageView.autoPinEdgesToSuperviewEdges()
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)

        self.closeIcon.autoPinEdgesToSuperviewEdges()
        self.closeIcon.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        
        self.userIconContainer.autoPinEdge(.top, to: .bottom, of: self.itemImageViewContainer, withOffset: -50.0)
        self.userIconContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.userIconView.autoPinEdgesToSuperviewEdges()
        self.userIconView.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        
        self.userNameTitleLabel.autoPinEdge(.top, to: .bottom, of: self.userIconContainer, withOffset: 30.0)
        self.userNameTitleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.userNameTextField.autoPinEdge(.top, to: .bottom, of: self.userNameTitleLabel, withOffset: 10.0)
        self.userNameTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.userNameTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.userNameTextField.autoSetDimension(.height, toSize: 50.0)
        
        self.registerButton.autoPinEdge(.top, to: .bottom, of: self.userNameTextField, withOffset: 20.0)
        self.registerButton.autoSetDimension(.height, toSize: 45.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }

    @objc private func tappedBannerImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
            self.willSelectBannerImage = true
        } else {
            print("The photo library is not available on this device")
        }
    }
    
    @objc private func tappedUserIcon() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
            self.willSelectBannerImage = false
        } else {
            print("The photo library is not available on this device")
        }
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
        
        UIImpactFeedbackGenerator().impactOccurred()
    }
    
    @objc private func tappedRegisterButton() {
        if
            let newUserName = self.userNameTextField.text,
            !newUserName.isEmpty
        {
            let userInfo = UserInfo(name: newUserName, topBanner: self.itemImageView.image, icon: self.userIconView.image)
            
            self.presenter.registerNewProfileButtonDidTap(userInfo: userInfo, editProfileView: self)
        } else {
            Toast.show("error: input user name", self.view)
        }
    }
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // どちらの画像を変更したいのか判定する
        if self.willSelectBannerImage {
            self.selectedBannerImage = selectedImage
        } else {
            self.selectedUserIcon = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
