import UIKit

class GalleryViewController: UIViewController {
    let scrollView = UIScrollView()
    let comingSoonLabel = UILabel()
    let comingSoonImageView = UIImageView(image: UIImage(named: "coming_soon"))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "Gallery"
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
        self.scrollView.addSubview(self.comingSoonLabel)
        self.scrollView.addSubview(self.comingSoonImageView)
    }
    
    private func configSubViews() {
        self.comingSoonLabel.text = "Coming Soon...🐧"
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.comingSoonLabel.textColor = .black
        self.comingSoonLabel.font = UIFont(name: "Oswald", size: 18.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.comingSoonLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.comingSoonLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.comingSoonImageView.autoPinEdge(.top, to: .bottom, of: self.comingSoonLabel, withOffset: 30.0)
        self.comingSoonImageView.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
