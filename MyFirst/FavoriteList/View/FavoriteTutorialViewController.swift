import UIKit

class FavoriteTutorialViewController: UIViewController {
    let backgroundView = UIControl()
    
    let contentView = UIView()
    
    let closeButton = CustomCloseButton()
    let descriptionLabel = UILabel()
    let descriptionImage = UIImageView(image: UIImage(named: "tutorial"))
    
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
    }
    
    private func configSubViews() {
        self.backgroundView.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.descriptionLabel.text = "あなたのお気に入りを追加してみましょう！\n\nお気に入りは「FOOD」や「PRODUCT」など、カテゴリ毎に10個まで登録できます。"
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionImage.contentMode = .scaleAspectFit
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .clear
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        self.contentView.layer.borderWidth = 1.0
        
        self.descriptionLabel.font = .boldSystemFont(ofSize: 15.0)
        self.descriptionLabel.textColor = .black
    }
    
    private func addConstraints() {
        self.backgroundView.autoPinEdgesToSuperviewEdges()
        
        self.contentView.autoPinEdge(toSuperviewEdge: .left, withInset: 40.0)
        self.contentView.autoPinEdge(toSuperviewEdge: .right, withInset: 40.0)
        self.contentView.autoCenterInSuperview()
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.descriptionLabel.autoPinEdge(.top, to: .bottom, of: self.closeButton, withOffset: 10.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.descriptionImage.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 30.0)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .left)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .right)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
        self.descriptionImage.autoAlignAxis(toSuperviewAxis: .vertical)
        self.descriptionImage.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 300.0))
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}
