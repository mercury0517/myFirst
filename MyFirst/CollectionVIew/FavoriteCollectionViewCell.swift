import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    var favorite: MyFavorite? {
        didSet {
            self.configMyFavorite()
        }
    }
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    let itemSize = UIScreen.main.bounds.width * 0.7
    
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
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        
        self.imageView.image = UIColor.lightGray.image(size: .init(width: self.itemSize, height: self.itemSize))
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 15.0
        
        self.titleLabel.numberOfLines = 0
    }
    
    private func applyStyling() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.imageView.autoSetDimensions(to: CGSize(width: self.itemSize, height: self.itemSize))
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: 5.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
    }
    
    private func configMyFavorite() {
        self.titleLabel.text = self.favorite?.title
        
        if let unwrappedImage = self.favorite?.image {
            self.imageView.image = unwrappedImage
        }
    }
}
