import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    var favorite: MyFavorite? {
        didSet {
            self.configMyFavorite()
        }
    }
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        self.imageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.imageView.layer.shadowColor = UIColor.lightGray.cgColor
        self.imageView.layer.shadowOpacity = 0.6
        self.imageView.layer.shadowRadius = 4
        
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
        self.titleLabel.numberOfLines = 0
    }
    
    private func applyStyling() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 12.0)
    }
    
    private func addConstraints() {
        self.imageView.autoSetDimensions(to: CGSize(width: 150.0, height: 150.0))
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: 5.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
    }
    
    private func configMyFavorite() {
        self.titleLabel.text = self.favorite?.title
        self.imageView.image = self.favorite?.image
    }
}
