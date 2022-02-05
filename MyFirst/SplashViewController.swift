import UIKit

class SplashViewController: UIViewController {
    let router: BaseRouter?
    
    let icon = UIImageView(image: UIImage(named: "scopp"))
    
    init(router: BaseRouter?) {
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.router = nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Splash画面を表示し終わったら、アプリのTop画面に切り替える
        sleep(1)
        self.router?.displayTabBarController()
    }

    private func addSubviews() {
        self.view.addSubview(self.icon)
    }
    
    private func configSubViews() {
    }
    
    private func applyStyling() {
        self.view.backgroundColor = CustomUIColor.turquoise
    }
    
    private func addConstraints() {
        self.icon.autoSetDimensions(to: CGSize(width: 200.0, height: 200.0))
        self.icon.autoCenterInSuperview()
    }
}
