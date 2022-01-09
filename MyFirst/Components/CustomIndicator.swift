import UIKit

class CustomIndicator: UIActivityIndicatorView {
    let textLabel = UILabel()
    
    init() {
        super.init(style: .large)
        
        self.addSubview(self.textLabel)
        
        self.textLabel.text = "お気に入り送受信中"
        
        self.color = .gray
        self.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.textLabel.textColor = .black
        self.textLabel.font = .systemFont(ofSize: 15.0)
        
        self.autoSetDimensions(to: CGSize(width: 250.0, height: 200.0))
        self.layer.cornerRadius = 10.0
        
        self.textLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
        self.textLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

