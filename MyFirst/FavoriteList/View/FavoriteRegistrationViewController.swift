import UIKit

class FavoriteRegistrationViewController: UIViewController {
    let categoryName: String
    let itemIndex: Int
    let presenter: FavoriteListPresenterProtocol
    
    var selectedImage: UIImage? {
        didSet {
            self.itemImageView.image = selectedImage
        }
    }
    
    // TODO: キャッシュがあれば、その画像を表示
    let itemImageView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    let inputImageButton = UIButton()
    
    let titleLabel = UILabel()
    let itemNameTextField = CustomTextField()
    let memoLabel = UILabel()
    let memoTextView = UITextView()
    let registerButton = UIButton()
    
    init(categoryName: String, itemIndex: Int, presenter: FavoriteListPresenterProtocol) {
        self.categoryName = categoryName
        self.itemIndex = itemIndex
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
        self.view.addSubview(self.inputImageButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.itemNameTextField)
        self.view.addSubview(self.memoLabel)
        self.view.addSubview(self.memoTextView)
        self.view.addSubview(self.registerButton)
    }
    
    private func configSubViews() {
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        
        self.inputImageButton.setTitle("INPUT IMAGE", for: .normal)
        self.inputImageButton.addTarget(self, action: #selector(self.tappedInputImageButton), for: .touchUpInside)
        
        self.titleLabel.text = "ITEM TITLE"
        
        self.itemNameTextField.placeholder = "input your favorite title"
        
        self.memoLabel.text = "OVERVIEW"
        
        self.registerButton.setTitle("REGISTER", for: .normal)
        self.registerButton.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.inputImageButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.inputImageButton.backgroundColor = .black
        self.inputImageButton.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        self.inputImageButton.layer.cornerRadius = 5.0
        
        self.titleLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.titleLabel.textColor = .black
        
        self.memoLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.memoLabel.textColor = .black
        
        self.memoTextView.backgroundColor = .white
        self.memoTextView.layer.cornerRadius = 5.0
        self.memoTextView.layer.borderWidth = 1.0
        self.memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.memoTextView.textColor = .black
        
        self.registerButton.backgroundColor = .black
        self.registerButton.layer.cornerRadius = 5.0
        self.registerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimension(.height, toSize: 200.0)
        
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
    }

    @objc private func tappedInputImageButton() {
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
    
    @objc private func tappedRegisterButton() {
        // TODO: タイトルが空の場合のvalidation
        if let newTitle = self.itemNameTextField.text {
            let newFavorite = MyFavorite(
                categoryName: self.categoryName,
                index: self.itemIndex,
                title: newTitle,
                image: self.selectedImage,
                memo: self.memoTextView.text,
                isCustomized: true
            )
            
            self.presenter.registerFavoriteButtonDidTap(favorite: newFavorite, registrationView: self)
            
            // ハプティックフィードバックを入れる
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
}

extension FavoriteRegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.selectedImage = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}
