import UIKit

class FriendFavoriteGroupView: UIView {
    let view: FriendDetailViewController
    let title: String
    let favoriteList: [MyFavorite]
    
    let titleLabel = UILabel()
    var collectionView: UICollectionView
    
    let itemSize = UIScreen.main.bounds.width * 0.5
    
    init(title: String, favoriteList: [MyFavorite], view: FriendDetailViewController) {
        self.title = title
        self.favoriteList = favoriteList
        self.view = view
        
        self.titleLabel.text = self.title
        
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 16.0
        flowLayout.itemSize = CGSize(width: self.itemSize, height: self.itemSize + 20.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        flowLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 1000.0, height: 270.0), collectionViewLayout: flowLayout
        )
        
        super.init(frame: CGRect())
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.collectionView)
    }
    
    private func configSubViews() {
        self.collectionView.register(FriendFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FriendFavoriteCollectionViewCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 18.0)
        
        self.collectionView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.autoSetDimension(.height, toSize: self.itemSize + 60.0)
        
        self.titleLabel.autoSetDimension(.height, toSize: 30.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        
        self.collectionView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 5.0)
        self.collectionView.autoPinEdge(toSuperviewEdge: .left)
        self.collectionView.autoPinEdge(toSuperviewEdge: .right)
        self.collectionView.autoSetDimension(.height, toSize: self.itemSize + 20.0)
    }
}

extension FriendFavoriteGroupView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "FriendFavoriteCollectionViewCell", for: indexPath) as! FriendFavoriteCollectionViewCell
        
        if !self.favoriteList.isEmpty {
            let targetFavorite = self.favoriteList[indexPath.row]
            
            cell.favorite = targetFavorite
        } else {
            // グレーの画像を表示しておく
            cell.favorite = MyFavorite(
                categoryName: "",
                index: indexPath.row,
                title: "",
                image: UIColor.lightGray.image(size: .init(width: 150.0, height: 150.0)),
                memo: nil,
                isCustomized: false
            )
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FriendFavoriteCollectionViewCell
        
        if let favorite = cell?.favorite {
            self.view.displayItemDetailView(favorite: favorite)
        }
    }
}
