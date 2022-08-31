import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    var favorite: MyFavorite? {
        didSet {
            self.configMyFavorite()
        }
    }
    
    let imageView = UIImageView()
    
    let itemSize = UIScreen.main.bounds.width / 2
    let itemHeight = UIScreen.main.bounds.width / 2
    
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
    }
    
    private func configSubViews() {
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        self.layer.borderWidth = 1.0
        
        self.imageView.image = UIImage(named: "sky")
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
    }
    
    private func applyStyling() {
    }
    
    private func addConstraints() {
        self.imageView.autoSetDimensions(to: CGSize(width: self.itemSize, height: self.itemHeight))
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        self.imageView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func configMyFavorite() {
        if let unwrappedImage = self.favorite?.image {
            self.imageView.image = unwrappedImage
        }
    }
}
