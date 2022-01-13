import UIKit

class FavoriteInputViewController: UIViewController {
    let categoryName: String
    let itemIndex: Int
    let presenter: FavoriteListPresenterProtocol
    
    let imageHeight = UIScreen.main.bounds.height * 0.40
    let isEdit: Bool
    var favorite: MyFavorite?
    
    var selectedImage: UIImage? {
        didSet {
            self.itemImageView.image = selectedImage
        }
    }
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIImage(named: "sky"))
    let closeButton = CustomCloseButton()
    let inputImageButton = UIButton()
    
    let titleLabel = UILabel()
    let itemNameTextField = CustomTextField()
    let memoLabel = UILabel()
    let memoTextView = CustomTextView()
    let registerButton = UIButton()
    
    init(categoryName: String, itemIndex: Int, presenter: FavoriteListPresenterProtocol, isEdit: Bool, favorite: MyFavorite? = nil) {
        self.categoryName = categoryName
        self.itemIndex = itemIndex
        self.presenter = presenter
        
        // for edit
        self.isEdit = isEdit
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }

    private func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.itemImageView)
        self.scrollView.addSubview(self.closeButton)
        self.scrollView.addSubview(self.inputImageButton)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.itemNameTextField)
        self.scrollView.addSubview(self.memoLabel)
        self.scrollView.addSubview(self.memoTextView)
        self.scrollView.addSubview(self.registerButton)
    }
    
    private func configSubViews() {
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.inputImageButton.setTitle("画像を選択", for: .normal)
        self.inputImageButton.addTarget(self, action: #selector(self.tappedInputImageButton), for: .touchUpInside)
        
        self.titleLabel.text = "タイトル"
        
        self.itemNameTextField.placeholder = "お気に入りタイトル"
        self.itemNameTextField.delegate = self
        
        self.memoLabel.text = "メモ"
        
        self.memoTextView.delegate = self
        
        self.registerButton.setTitle("OK", for: .normal)
        self.registerButton.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        
        // for edit
        if self.isEdit {
            self.itemImageView.image = self.favorite?.image
            self.itemNameTextField.text = self.favorite?.title
            self.memoTextView.text = self.favorite?.memo
        }
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.inputImageButton.titleLabel?.font = UIFont(name: "Oswald", size: 12.0)
        self.inputImageButton.backgroundColor = CustomUIColor.turquoise
        self.inputImageButton.contentEdgeInsets = UIEdgeInsets(top: 3.0, left: 10.0, bottom: 3.0, right: 10.0)
        self.inputImageButton.layer.cornerRadius = 5.0
        
        self.titleLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.titleLabel.textColor = .black
        
        self.itemNameTextField.textColor = .black
        
        self.memoLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.memoLabel.textColor = .black
        
        self.memoTextView.backgroundColor = .white
        self.memoTextView.layer.cornerRadius = 5.0
        self.memoTextView.layer.borderWidth = 1.0
        self.memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.memoTextView.textColor = .black
        
        self.registerButton.backgroundColor = CustomUIColor.turquoise
        self.registerButton.layer.cornerRadius = 5.0
        self.registerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: self.imageHeight))
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.inputImageButton.autoPinEdge(.top, to: .bottom, of: self.itemImageView, withOffset: 10.0)
        self.inputImageButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.inputImageButton, withOffset: 20.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.itemNameTextField.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 10.0)
        self.itemNameTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.itemNameTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.itemNameTextField.autoSetDimension(.height, toSize: 50.0)
        
        self.memoLabel.autoPinEdge(.top, to: .bottom, of: self.itemNameTextField, withOffset: 20.0)
        self.memoLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.memoTextView.autoPinEdge(.top, to: .bottom, of: self.memoLabel, withOffset: 10.0)
        self.memoTextView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.memoTextView.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.memoTextView.autoSetDimension(.height, toSize: 100.0)
        
        self.registerButton.autoPinEdge(.top, to: .bottom, of: self.memoTextView, withOffset: 20.0)
        self.registerButton.autoSetDimension(.height, toSize: 45.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }

    @objc private func tappedInputImageButton() {
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
    
    @objc private func tappedRegisterButton() {
        if let newTitle = self.itemNameTextField.text {
            let newFavorite = MyFavorite(
                categoryName: self.categoryName,
                index: self.itemIndex,
                title: newTitle,
                image: self.itemImageView.image,
                memo: self.memoTextView.text,
                isCustomized: true
            )
            
            if self.isEdit {
                self.presenter.updateFavoriteButtonDidTap(favorite: newFavorite)
            } else {
                self.presenter.registerFavoriteButtonDidTap(favorite: newFavorite, registrationView: self)
            }
        } else {
            Toast.show("error: input favorite title", self.view)
        }
    }
}

extension FavoriteInputViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.selectedImage = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension FavoriteInputViewController: UITextFieldDelegate, UITextViewDelegate {
    // キーボードが現れた時に、画面全体をずらす。
    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform
        })
    }

    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Returnキーを押したときにキーボードを下げる
        return true
    }
}
