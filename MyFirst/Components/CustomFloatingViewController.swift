import FloatingPanel
import UIKit

class HalfModalViewController: UIViewController {
    let image: UIImage
    
    let titleLabel = UILabel()
    let shareLineButton = UIButton()
    let shareTwitterButton = UIButton()
    let openPhotoLibraryButton = UIButton()
    
    let closeButton = CustomCloseButton()
    
    init(image: UIImage) {
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.image = UIImage()
        
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
        self.view.addSubview(self.shareLineButton)
        self.view.addSubview(self.shareTwitterButton)
        self.view.addSubview(self.openPhotoLibraryButton)
        self.view.addSubview(self.closeButton)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "Your favorites have saved in Photo Library"
        self.titleLabel.numberOfLines = 0
        
        self.shareLineButton.setTitle("Share with LINE", for: .normal)
        self.shareLineButton.addTarget(self, action: #selector(self.tappedLineButton), for: .touchUpInside)
        
        self.shareTwitterButton.setTitle("Share with Twitter", for: .normal)
        self.shareTwitterButton.addTarget(self, action: #selector(self.tappedTwitterButton), for: .touchUpInside)
        
        self.openPhotoLibraryButton.setTitle("Open Photo Library", for: .normal)
        self.openPhotoLibraryButton.addTarget(self, action: #selector(self.tappedOpenPhotoLibraryButton), for: .touchUpInside)
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 24.0)
        
        self.shareLineButton.setTitleColor(.white, for: .normal)
        self.shareLineButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
        self.shareLineButton.backgroundColor = UIColor.rgba(red: 0, green: 185, blue: 0, alpha: 1)
        self.shareLineButton.layer.cornerRadius = 20.0
        
        self.shareTwitterButton.setTitleColor(.white, for: .normal)
        self.shareTwitterButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
        self.shareTwitterButton.backgroundColor = UIColor.rgba(red: 85, green: 172, blue: 238, alpha: 1)
        self.shareTwitterButton.layer.cornerRadius = 20.0
        
        self.openPhotoLibraryButton.setTitleColor(.white, for: .normal)
        self.openPhotoLibraryButton.titleLabel?.font = UIFont(name: "Oswald", size: 20.0)
        self.openPhotoLibraryButton.backgroundColor = .black
        self.openPhotoLibraryButton.layer.cornerRadius = 20.0
    }
    
    private func addConstraints() {
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 55.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.shareLineButton.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 30.0)
        self.shareLineButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.shareLineButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.shareTwitterButton.autoPinEdge(.top, to: .bottom, of: self.shareLineButton, withOffset: 20.0)
        self.shareTwitterButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.shareTwitterButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.openPhotoLibraryButton.autoPinEdge(.top, to: .bottom, of: self.shareTwitterButton, withOffset: 20.0)
        self.openPhotoLibraryButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.openPhotoLibraryButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
    
    // MARK: share with LINE
    @objc private func tappedLineButton() {
        let pasteBoard = UIPasteboard.general
        pasteBoard.image = self.image
     
        let lineSchemeImage: String = "line://msg/image/%@"
        let scheme = String(format: lineSchemeImage, pasteBoard.name as CVarArg)
        let messageURL: URL! = URL(string: scheme)
        
        if UIApplication.shared.canOpenURL(messageURL) {
            UIApplication.shared.open(messageURL, options: [:], completionHandler: nil)
        } else {
            print("failed to open..")
        }
    }
    
    // MARK: share with Twitter
    @objc private func tappedTwitterButton() {
        let text = "(写真ライブラリからキャプチャを選択してください)"
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
    
    // MARK: open Photo Library
    @objc private func tappedOpenPhotoLibraryButton() {
        if let url = URL(string: "photos-redirect:") {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: close button
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}

class CustomFloatingViewController: UIViewController, FloatingPanelControllerDelegate {
    let image: UIImage
    
    init(image: UIImage) {
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.image = UIImage()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    var floatPanelController: FloatingPanelController!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.floatPanelController = FloatingPanelController()
        self.floatPanelController.delegate = self
 
        let contentVC = HalfModalViewController(image: image)
        self.floatPanelController.set(contentViewController: contentVC)
        
        self.floatPanelController.addPanel(toParent: self)
    }
}
