import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    var favorite: MyFavorite? {
        didSet {
            self.configMyFavorite()
        }
    }
    
    let imageView = UIImageView()
    let titleContainer = UIView()
    let titleLabel = UILabel()
    
    let itemSize = UIScreen.main.bounds.width * 0.6
    
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
    
    // タップした感が伝わる様に
//    func animateCard() {
//        self.imageView.alpha = 0.6
//        
//        DispatchQueue.main.async {
//            UIImageView.animate(
//                withDuration: 1.0,
//                delay: 0.0,
//                options: [.curveEaseIn],
//                animations: {
//                    self.imageView.alpha = 1.0
//                }
//            )
//        }
//    }
    
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
        
        self.titleLabel.numberOfLines = 2
    }
    
    private func applyStyling() {
        self.titleContainer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont(name: "Oswald", size: 20.0)
    }
    
    private func addConstraints() {
        self.imageView.autoSetDimensions(to: CGSize(width: self.itemSize, height: self.itemSize))
        self.imageView.autoPinEdge(toSuperviewEdge: .top)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        
        self.titleContainer.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoCenterInSuperview()
    }
    
    private func configMyFavorite() {
        self.titleLabel.text = self.favorite?.title
        
        if let unwrappedImage = self.favorite?.image {
            self.imageView.image = unwrappedImage
        }
        
        self.titleContainer.isHidden = self.titleLabel.text?.isEmpty ?? true
    }
}
