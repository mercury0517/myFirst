import UIKit

class FavoriteInputViewController: UIViewController {
    let categoryName: String
    let itemIndex: Int
    let presenter: FavoriteListPresenterProtocol
    
    let isEdit: Bool
    var favorite: MyFavorite?
    
    var selectedImage: UIImage? {
        didSet {
            self.itemImageView.image = selectedImage
        }
    }
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)))
    let closeButton = UIControl()
    let closeIcon = UIImageView(image: UIImage(named: "close"))
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
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.itemImageView)
        self.scrollView.addSubview(self.closeButton)
        self.closeButton.addSubview(self.closeIcon)
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
        
        self.inputImageButton.setTitle("INPUT IMAGE", for: .normal)
        self.inputImageButton.addTarget(self, action: #selector(self.tappedInputImageButton), for: .touchUpInside)
        
        self.titleLabel.text = "ITEM TITLE"
        
        self.itemNameTextField.placeholder = "input your favorite title"
        
        self.memoLabel.text = "OVERVIEW"
        
        self.registerButton.setTitle("REGISTER", for: .normal)
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
        
        self.inputImageButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
        self.inputImageButton.backgroundColor = CustomUIColor.turquoise
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
        
        self.registerButton.backgroundColor = CustomUIColor.turquoise
        self.registerButton.layer.cornerRadius = 5.0
        self.registerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 400.0))
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)

        self.closeIcon.autoPinEdgesToSuperviewEdges()
        self.closeIcon.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        
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
