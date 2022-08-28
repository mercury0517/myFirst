import FloatingPanel
import UIKit

class HalfModalViewController: UIViewController {
    let image: UIImage
    let favoriteText: String?
    
    let titleLabel = UILabel()
    let openPhotoLibraryButton = UIButton()
    let addToGalleryButton = UIButton()
    let shareButton = UIButton()
    
    let closeButton = CustomCloseButton()
    
    init(image: UIImage, favoriteText: String?) {
        self.image = image
        self.favoriteText = favoriteText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.image = UIImage()
        self.favoriteText = nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        self.view.backgroundColor = .white
    }
    
    private func addSubviews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.addToGalleryButton)
        self.view.addSubview(self.shareButton)
        self.view.addSubview(self.openPhotoLibraryButton)
        self.view.addSubview(self.closeButton)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "Your favorites have saved in Photo Library"
        self.titleLabel.numberOfLines = 0
        
        self.openPhotoLibraryButton.setTitle("Open Photo Library", for: .normal)
        self.openPhotoLibraryButton.addTarget(self, action: #selector(self.tappedOpenPhotoLibraryButton), for: .touchUpInside)
        
        self.addToGalleryButton.setTitle("Add To GALLERY", for: .normal)
        self.addToGalleryButton.addTarget(self, action: #selector(self.tappedAddToGalleryButton), for: .touchUpInside)
        
        self.shareButton.setTitle("Share Your Favorites", for: .normal)
        self.shareButton.addTarget(self, action: #selector(self.tappedShareButton), for: .touchUpInside)
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 20.0)
        
        self.openPhotoLibraryButton.setTitleColor(.white, for: .normal)
        self.openPhotoLibraryButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
        self.openPhotoLibraryButton.backgroundColor = .black
        self.openPhotoLibraryButton.layer.cornerRadius = 10.0
        
        self.addToGalleryButton.setTitleColor(.white, for: .normal)
        self.addToGalleryButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
        self.addToGalleryButton.backgroundColor = CustomUIColor.customRed
        self.addToGalleryButton.layer.cornerRadius = 10.0
        
        self.shareButton.setTitleColor(.white, for: .normal)
        self.shareButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
        self.shareButton.backgroundColor = CustomUIColor.turquoise
        self.shareButton.layer.cornerRadius = 10.0
    }
    
    private func addConstraints() {
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 55.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.openPhotoLibraryButton.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 30.0)
        self.openPhotoLibraryButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.openPhotoLibraryButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.addToGalleryButton.autoPinEdge(.top, to: .bottom, of: self.openPhotoLibraryButton, withOffset: 20.0)
        self.addToGalleryButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.addToGalleryButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.shareButton.autoPinEdge(.top, to: .bottom, of: self.addToGalleryButton, withOffset: 20.0)
        self.shareButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.shareButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
    
    // MARK: open Photo Library
    @objc private func tappedOpenPhotoLibraryButton() {
        if let url = URL(string: "photos-redirect:") {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: add to GALLERY
    @objc private func tappedAddToGalleryButton() {
        guard let title = self.favoriteText else {
            Toast.show("failed to add to GALLERY", self.view)
            return
        }
    }
    
    // MARK: share button
    @objc private func tappedShareButton() {
        let text = self.favoriteText ?? "私のお気に入り"
        let hashTag = "#私のお気に入り #DIGIT #ディグイット"
        let completedText = text + "\n" + hashTag

        let activityVc = UIActivityViewController(
            activityItems: [completedText, self.image], applicationActivities: nil
        )

        self.present(activityVc, animated: true)
    }
    
    // MARK: close button
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}

class CustomFloatingViewController: UIViewController, FloatingPanelControllerDelegate {
    let image: UIImage
    let favoriteText: String?
    
    init(image: UIImage, favoriteText: String?) {
        self.image = image
        self.favoriteText = favoriteText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.image = UIImage()
        self.favoriteText = nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    var floatPanelController: FloatingPanelController!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.floatPanelController = FloatingPanelController()
        self.floatPanelController.delegate = self
 
        let contentVC = HalfModalViewController(image: self.image, favoriteText: self.favoriteText)
        self.floatPanelController.set(contentViewController: contentVC)
        
        self.floatPanelController.addPanel(toParent: self)
    }
}
