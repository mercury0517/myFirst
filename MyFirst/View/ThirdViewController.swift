import UIKit
import PureLayout

class ThirdViewController: UIViewController{
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
        self.textLabel.text = "3番目の画面だよ"
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.textLabel.textColor = .blue
    }
    
    private func addConstraints() {
        self.textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.textLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}

