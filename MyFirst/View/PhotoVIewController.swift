import UIKit
import PureLayout

class PhotoViewController: UIViewController {
    let scrollView = UIScrollView()
    let deleteCacheButton = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
//        let appleManager = AppleMusicManager()
//        appleManager.fetchAlbumIDList()
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
        self.scrollView.addSubview(self.deleteCacheButton)
    }
    
    private func configSubViews() {
        self.deleteCacheButton.setTitle("キャッシュをクリア", for: .normal)
        self.deleteCacheButton.addTarget(self, action: #selector(self.tappedDeleteCacheButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.deleteCacheButton.backgroundColor = .red
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.deleteCacheButton.autoCenterInSuperview()
    }
    
    @objc private func tappedDeleteCacheButton() {
        for category in FavoriteCategory.allCases {
            UserDefaults.standard.removeObject(forKey: category.rawValue)
        }
        
        UserDefaults.standard.removeObject(forKey: "bannerImage")
    }
}
