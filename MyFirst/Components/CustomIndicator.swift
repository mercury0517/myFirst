import UIKit

class CustomIndicator: UIActivityIndicatorView {
    let textLabel = UILabel()
    
    init() {
        super.init(style: .large)
        
        self.addSubview(self.textLabel)
        
        self.textLabel.text = "お気に入り送受信中"
        self.textLabel.numberOfLines = 0
        
        self.color = .white
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.textLabel.textColor = .white
        self.textLabel.font = .systemFont(ofSize: 15.0)
        
        self.autoSetDimensions(to: CGSize(width: 200.0, height: 150.0))
        self.layer.cornerRadius = 10.0
        
        self.textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.textLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

