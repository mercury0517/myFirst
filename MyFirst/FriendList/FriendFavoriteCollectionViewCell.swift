import UIKit

class FriendFavoriteCollectionViewCell: UICollectionViewCell {
    var favorite: MyFavorite? {
        didSet {
            self.configMyFavorite()
        }
    }
    
    let imageView = UIImageView()
    let titleContainer = UIView()
    let titleLabel = UILabel()
    
    let itemSize = UIScreen.main.bounds.width * 0.5
    
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
        self.imageView.addSubview(self.titleContainer)
        self.titleContainer.addSubview(self.titleLabel)
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
        self.titleContainer.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.imageView.autoSetDimensions(to: CGSize(width: self.itemSize, height: self.itemSize))
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleContainer.autoPinEdge(toSuperviewEdge: .left)
        self.titleContainer.autoPinEdge(toSuperviewEdge: .right)
        self.titleContainer.autoPinEdge(toSuperviewEdge: .bottom)
        self.titleContainer.autoSetDimension(.height, toSize: 65.0)
        
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
    }
    
    private func configMyFavorite() {
        self.titleLabel.text = self.favorite?.title
        
        if let unwrappedImage = self.favorite?.image {
            self.imageView.image = unwrappedImage
        }
        
        self.titleContainer.isHidden = self.titleLabel.text?.isEmpty ?? true
    }
}
