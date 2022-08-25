import UIKit

class ExchangeTutorialViewController: UIViewController {
    let scrollView = UIScrollView()
    
    let step1Label = UILabel()
    let step1ImageView = UIImageView(image: UIImage(named: "step1"))
    
    let step2Label = UILabel()
    let step2ImageView = UIImageView(image: UIImage(named: "step2"))
    
    let step3Label = UILabel()
    let step3ImageView = UIImageView(image: UIImage(named: "step3"))
    
    let step4Label = UILabel()
    let step4ImageView = UIImageView(image: UIImage(named: "step4"))
    
    let step5Label = UILabel()
    let step5ImageView = UIImageView(image: UIImage(named: "step5"))
    
    let step6Label = UILabel()
    let step6ImageView = UIImageView(image: UIImage(named: "step6"))
    
    let step7Label = UILabel()
    let step7ImageView = UIImageView(image: UIImage(named: "step7"))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "How to exchange favorites"
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
        
        self.navigationItem.setLeftBarButton(
            UIBarButtonItem(
                title: "Cancel",
                style: .plain,
                target: self,
                action: #selector(self.tappedCancelButton)
            ),
            animated: true
       )
    }
    
    @objc private func tappedCancelButton() {
        self.dismiss(animated: true)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.step1Label)
        self.scrollView.addSubview(self.step1ImageView)
        self.scrollView.addSubview(self.step2Label)
        self.scrollView.addSubview(self.step2ImageView)
        self.scrollView.addSubview(self.step3Label)
        self.scrollView.addSubview(self.step3ImageView)
        self.scrollView.addSubview(self.step4Label)
        self.scrollView.addSubview(self.step4ImageView)
        self.scrollView.addSubview(self.step5Label)
        self.scrollView.addSubview(self.step5ImageView)
        self.scrollView.addSubview(self.step6Label)
        self.scrollView.addSubview(self.step6ImageView)
        self.scrollView.addSubview(self.step7Label)
        self.scrollView.addSubview(self.step7ImageView)
    }
    
    private func configSubViews() {
        self.step1Label.text = "1. User A taps \"Send the invitation\". At this time, it is necessary to turn on WiFi and Bluetooth on the iPhone."
        self.step1Label.numberOfLines = 0
        self.step1ImageView.contentMode = .scaleAspectFit
        
        self.step2Label.text = "2. User B taps \"Send the invitation\". iPhone WiFi and Bluetooth must be turned on for this device as well."
        self.step2Label.numberOfLines = 0
        self.step2ImageView.contentMode = .scaleAspectFit
        
        self.step3Label.text = "3. User B will appear on User A's screen. Tap \"Invite\" to send an invitation request to User B."
        self.step3Label.numberOfLines = 0
        self.step3ImageView.contentMode = .scaleAspectFit
        
        self.step4Label.text = "4. When the dialog box appears on User B's screen to select whether to accept the invitation, tap \"Connect\"."
        self.step4Label.numberOfLines = 0
        self.step4ImageView.contentMode = .scaleAspectFit
        
        self.step5Label.text = "5. When \"Connecting\" appears to the right of your user name, the connection is successful. You are now connected and can exchange favorites with each other."
        self.step5Label.numberOfLines = 0
        self.step5ImageView.contentMode = .scaleAspectFit
        
        self.step6Label.text = "6. User A or User B taps \"Send Favorites\" to begin sending favorites. When communication is complete, the dialog will disappear. Sending Favorites is now complete."
        self.step6Label.numberOfLines = 0
        self.step6ImageView.contentMode = .scaleAspectFit
        
        self.step7Label.text = "7. Go to the \"FRIEND\" tab to add friends with whom you have exchanged favorites and to see your favorites."
        self.step7Label.numberOfLines = 0
        self.step7ImageView.contentMode = .scaleAspectFit
    }
    
    private func applyStyling() {
        self.view.backgroundColor = CustomUIColor.lightBackground
        
        self.step1Label.font = .boldSystemFont(ofSize: 15.0)
        self.step1Label.textColor = .black
        
        self.step2Label.font = .boldSystemFont(ofSize: 15.0)
        self.step2Label.textColor = .black
        
        self.step3Label.font = .boldSystemFont(ofSize: 15.0)
        self.step3Label.textColor = .black
        
        self.step4Label.font = .boldSystemFont(ofSize: 15.0)
        self.step4Label.textColor = .black
        
        self.step5Label.font = .boldSystemFont(ofSize: 15.0)
        self.step5Label.textColor = .black
        
        self.step6Label.font = .boldSystemFont(ofSize: 15.0)
        self.step6Label.textColor = .black
        
        self.step7Label.font = .boldSystemFont(ofSize: 15.0)
        self.step7Label.textColor = .black
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.step1Label.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.step1Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step1Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step1ImageView.autoPinEdge(.top, to: .bottom, of: self.step1Label, withOffset: 10.0)
        self.step1ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step1ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step1ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step1ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.step2Label.autoPinEdge(.top, to: .bottom, of: self.step1ImageView, withOffset: 50.0)
        self.step2Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step2Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step2ImageView.autoPinEdge(.top, to: .bottom, of: self.step2Label, withOffset: 10.0)
        self.step2ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step2ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step2ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step2ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.step3Label.autoPinEdge(.top, to: .bottom, of: self.step2ImageView, withOffset: 50.0)
        self.step3Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step3Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step3ImageView.autoPinEdge(.top, to: .bottom, of: self.step3Label, withOffset: 10.0)
        self.step3ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step3ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step3ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step3ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.step4Label.autoPinEdge(.top, to: .bottom, of: self.step3ImageView, withOffset: 50.0)
        self.step4Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step4Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step4ImageView.autoPinEdge(.top, to: .bottom, of: self.step4Label, withOffset: 10.0)
        self.step4ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step4ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step4ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step4ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.step5Label.autoPinEdge(.top, to: .bottom, of: self.step4ImageView, withOffset: 50.0)
        self.step5Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step5Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step5ImageView.autoPinEdge(.top, to: .bottom, of: self.step5Label, withOffset: 10.0)
        self.step5ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step5ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step5ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step5ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.step6Label.autoPinEdge(.top, to: .bottom, of: self.step5ImageView, withOffset: 50.0)
        self.step6Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step6Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step6ImageView.autoPinEdge(.top, to: .bottom, of: self.step6Label, withOffset: 10.0)
        self.step6ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step6ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step6ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step6ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
        
        self.step7Label.autoPinEdge(.top, to: .bottom, of: self.step6ImageView, withOffset: 50.0)
        self.step7Label.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.step7Label.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.step7ImageView.autoPinEdge(.top, to: .bottom, of: self.step7Label, withOffset: 10.0)
        self.step7ImageView.autoPinEdge(toSuperviewEdge: .left)
        self.step7ImageView.autoPinEdge(toSuperviewEdge: .right)
        self.step7ImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40.0)
        self.step7ImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.step7ImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 350.0))
    }
}
