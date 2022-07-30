import UIKit

class FavoriteTutorialViewController: UIViewController {
    let backgroundView = UIControl()
    
    let contentView = UIView()
    let descriptionLabel = UILabel()
    let descriptionImage = UIImageView(image: UIImage(named: "tutorial"))
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
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.descriptionImage)
        self.contentView.addSubview(self.okButton)
    }
    
    private func configSubViews() {
        self.backgroundView.addTarget(self, action: #selector(self.tappedOKButton), for: .touchUpInside)
        
        self.descriptionLabel.text = "Let's add your favorites! You can register up to 10 favorites.\n\nAfter you have registered your favorites, you can share them with your close friends and family from the \"EXCHANGE\" tab."
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionImage.contentMode = .scaleAspectFit
        
        self.okButton.setTitle("OK", for: .normal)
        self.okButton.addTarget(self, action: #selector(self.tappedOKButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .clear
        
        self.contentView.backgroundColor = CustomUIColor.lightBackground
        self.contentView.layer.cornerRadius = 10.0
        
        self.descriptionLabel.font = UIFont(name: "Oswald", size: 16.0)
        self.descriptionLabel.textColor = .black
        
        self.okButton.backgroundColor = CustomUIColor.turquoise
        self.okButton.setTitleColor(.white, for: .normal)
    }
    
    private func addConstraints() {
        self.backgroundView.autoPinEdgesToSuperviewEdges()
        
        self.contentView.autoPinEdge(toSuperviewEdge: .left, withInset: 32.0)
        self.contentView.autoPinEdge(toSuperviewEdge: .right, withInset: 32.0)
        self.contentView.autoCenterInSuperview()
        
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.descriptionImage.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 20.0)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .left)
        self.descriptionImage.autoPinEdge(toSuperviewEdge: .right)
        self.descriptionImage.autoAlignAxis(toSuperviewAxis: .vertical)
        self.descriptionImage.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 250.0))
        
        self.okButton.autoPinEdge(.top, to: .bottom, of: self.descriptionImage, withOffset: 20.0)
        self.okButton.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.okButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        self.okButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
    }
    
    @objc private func tappedOKButton() {
        self.dismiss(animated: true)
    }
}
