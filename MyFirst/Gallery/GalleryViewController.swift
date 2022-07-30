import UIKit

class GalleryViewController: UIViewController {
    let scrollView = UIScrollView()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
    }
    
    private func configSubViews() {
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .green
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
    }
}
