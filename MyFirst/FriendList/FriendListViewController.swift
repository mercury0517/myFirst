import UIKit

class FriendListViewController: UIViewController {
    let textLabel = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        self.view.addSubview(self.textLabel)
    }
    
    private func configSubViews() {
        self.textLabel.text = "ここに友達が表示されるよ"
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.textLabel.textColor = .black
    }
    
    private func addConstraints() {
        self.textLabel.autoCenterInSuperview()
    }
}
