import UIKit

class CustomIndicator: UIActivityIndicatorView {
    init() {
        super.init(style: .large)
        
        self.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

