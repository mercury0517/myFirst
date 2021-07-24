import UIKit
import PureLayout

class PhotoViewController: UIViewController {
    let scrollView = UIScrollView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let appleManager = AppleMusicManager()
        appleManager.fetchAlbumIDList()
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
        self.view.addSubview(self.scrollView)
    }
    
    private func configSubViews() {
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
    }
}
