import UIKit

class FavoriteGroupView: UIView {
    let title: String
    var presenter: FavoriteListPresenterProtocol?
    
    var countOfItem: Int = 0
    
    let titleLabel = UILabel()
    var collectionView: UICollectionView
    
    init(title: String, presenter: FavoriteListPresenterProtocol?) {
        self.title = title
        self.titleLabel.text = self.title
        
        self.presenter = presenter
        
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 16.0
        flowLayout.itemSize = CGSize(width: 150.0, height: 200.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        flowLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 1000.0, height: 300.0), collectionViewLayout: flowLayout
        )
        
        super.init(frame: CGRect())
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.loadItemsFromCache()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadItemsFromCache() {
        
    }
    
    private func addSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.collectionView)
    }
    
    private func configSubViews() {
        self.collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 15.0)
        
        self.collectionView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.autoSetDimension(.height, toSize: 230.0)
        
        self.titleLabel.autoSetDimension(.height, toSize: 30.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        
        self.collectionView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 5.0)
        self.collectionView.autoPinEdge(toSuperviewEdge: .left)
        self.collectionView.autoPinEdge(toSuperviewEdge: .right)
        self.collectionView.autoSetDimension(.height, toSize: 180.0)
    }
}

extension FavoriteGroupView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if
            let data = UserDefaults.standard.object(forKey: self.title) as? Data,
            let cachedFavoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite]
        {
            if cachedFavoriteList.count == 3 {
                return cachedFavoriteList.count
            } else {
                return cachedFavoriteList.count + 1
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        if
            let data = UserDefaults.standard.object(forKey: self.title) as? Data,
            let cachedFavoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite]
        {
            // アイテムの上限に達しておらず、表示したいアイテムは出し終えた時
            if
                cachedFavoriteList.count < 3 && cachedFavoriteList.count < indexPath.row + 1
            {
                cell.favorite = MyFavorite(categoryName: "", index: 0, title: "Let's add an item", image: nil)
            } else {
                let targetFavorite = cachedFavoriteList[indexPath.row]
                
                cell.favorite = MyFavorite(
                    categoryName: targetFavorite.categoryName,
                    index: targetFavorite.index,
                    title: targetFavorite.title,
                    image: targetFavorite.image
                )
            }
        } else {
            cell.favorite = MyFavorite(categoryName: "", index: 0, title: "Let's add an item", image: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.favoriteCellDidTap(title: self.title, index: indexPath.row)
    }
}

extension UIColor {
    func image(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(.init(origin: .zero, size: size))
        }
    }
}
