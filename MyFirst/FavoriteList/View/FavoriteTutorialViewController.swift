import UIKit

class FavoriteTutorialViewController: UIViewController {
    let backgroundView = UIControl()
    
    let contentView = UIView()
    
    let closeButton = CustomCloseButton()
    let descriptionLabel = UILabel()
    let descriptionImage = UIImageView(image: UIImage(named: "step1"))
    let okButton = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "お気に入りの交換方法"
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
    }
    
    private func addSubviews() {
        self.view.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.contentView)
        self.contentView.addSubview(self.closeButton)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.descriptionImage)
        self.contentView.addSubview(self.okButton)
    }
    
    private func configSubViews() {
        self.backgroundView.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.descriptionLabel.text = "あなたのお気に入りを追加してみましょう！\n\nお気に入りは「FOOD」や「PRODUCT」など、カテゴリ毎に10個登録できます。"
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionImage.contentMode = .scaleAspectFit
        
        self.okButton.setTitle("OK", for: .normal)
        self.okButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .clear
        
        self.backgroundView.backgroundColor = .black.withAlphaComponent(0.1)
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10.0
        
        self.descriptionLabel.font = .boldSystemFont(ofSize: 15.0)
        self.descriptionLabel.textColor = .black
        
        self.okButton.titleLabel?.font = .systemFont(ofSize: 15.0)
        self.okButton.backgroundColor = CustomUIColor.turquoise
        self.okButton.setTitleColor(.white, for: .normal)
    }
    
    private func addConstraints() {
        self.backgroundView.autoPinEdgesToSuperviewEdges()
        
        self.contentView.autoPinEdge(toSuperviewEdge: .left, withInset: 60.0)
        self.contentView.autoPinEdge(toSuperviewEdge: .right, withInset: 60.0)
        self.contentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 150.0)
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.descriptionImage.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 30.0)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .left)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .right)
        self.descriptionImage.autoAlignAxis(toSuperviewAxis: .vertical)
        self.descriptionImage.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.okButton.autoPinEdge(.top, to: .bottom, of: self.descriptionImage, withOffset: 40.0)
        self.okButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.okButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.okButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}
