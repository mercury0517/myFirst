import FloatingPanel
import UIKit

class HalfModalViewController: UIViewController {
    let titleLabel = UILabel()
    let closeButton = CustomCloseButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        self.view.backgroundColor = .white
    }
    
    private func addSubviews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.closeButton)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "Share your screenshots"
        self.titleLabel.numberOfLines = 0
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 24.0)
    }
    
    private func addConstraints() {
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 55.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}

class CustomFloatingViewController: UIViewController, FloatingPanelControllerDelegate {
    var floatPanelController: FloatingPanelController!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.floatPanelController = FloatingPanelController()
        self.floatPanelController.delegate = self
 
        let contentVC = HalfModalViewController()
        self.floatPanelController.set(contentViewController: contentVC)
        
        self.floatPanelController.addPanel(toParent: self)
    }
}
