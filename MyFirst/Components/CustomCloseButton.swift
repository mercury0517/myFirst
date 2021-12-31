import UIKit

class CustomCloseButton: UIControl {
    let closeIcon = UIImageView(image: UIImage(named: "close"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
        self.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        self.addSubview(visualEffectView)
        visualEffectView.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        visualEffectView.isUserInteractionEnabled = false
        
        self.addSubview(self.closeIcon)
        self.closeIcon.autoSetDimensions(to: CGSize(width: 20.0, height: 20.0))
        self.closeIcon.autoCenterInSuperview()
        self.closeIcon.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
