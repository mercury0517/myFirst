import UIKit

class CustomIndicator: UIActivityIndicatorView {
    let textLabel = UILabel()
    
    init() {
        super.init(style: .large)
        
        self.addSubview(self.textLabel)
        
        self.textLabel.text = "お気に入り送受信中\n※この処理には数分かかる事があります"
        self.textLabel.numberOfLines = 2
        
        self.color = .gray
        self.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.textLabel.textColor = .black
        self.textLabel.font = .systemFont(ofSize: 15.0)
        
        self.autoSetDimension(.height, toSize: 160.0)
        self.layer.cornerRadius = 10.0
        
        self.textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.textLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.textLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

