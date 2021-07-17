import UIKit

class NewsView: UIView {
    let updateTime: String
    let title: String
    
    let updateTimeLabel = UILabel()
    let titleLabel = UILabel()
    
    init(updateTime: String, title: String) {
        self.updateTime = updateTime
        self.title = title
        
        super.init(frame: CGRect())
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(self.updateTimeLabel)
        self.addSubview(self.titleLabel)
    }
    
    func configSubViews() {
        self.updateTimeLabel.text = updateTime
        
        self.titleLabel.text = title
        self.titleLabel.numberOfLines = 0
    }
    
    func applyStyling() {
        self.backgroundColor = .white
        
        self.updateTimeLabel.textColor = .lightGray
        self.updateTimeLabel.font = UIFont(name: "Oswald", size: 12.0)
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 12.0)
    }
    
    func addConstraints() {
        self.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 32.0)
        
        self.updateTimeLabel.autoPinEdge(toSuperviewEdge: .top)
        self.updateTimeLabel.autoPinEdge(toSuperviewEdge: .left)
        self.updateTimeLabel.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.updateTimeLabel, withOffset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
}
