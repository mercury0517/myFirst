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
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
        
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
    }
    
    private func applyStyling() {
    }
    
    private func addConstraints() {
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: 10.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
    }
    
    private func configImage() {
        self.imageView.image = self.image
    }
    
    private func configTitle() {
        self.titleLabel.text = title
    }
}
