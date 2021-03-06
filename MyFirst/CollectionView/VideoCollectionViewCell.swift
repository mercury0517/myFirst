import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    var image: UIImage? {
        didSet {
            self.configImage()
        }
    }
    var title: String? {
        didSet {
            self.configTitle()
        }
    }
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubviews() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
    }
    
    private func configSubViews() {
        self.titleLabel.numberOfLines = 1
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        
        self.titleLabel.font = .systemFont(ofSize: 12.0)
        self.titleLabel.textColor = .black
    }
    
    private func addConstraints() {
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
    }
    
    private func configImage() {
        self.imageView.image = self.image
    }
    
    private func configTitle() {
        self.titleLabel.text = title
    }
}
