import UIKit

class FriendFavoriteGroupView: UIView {
    let view: FriendDetailViewController
    let favoriteList: [MyFavorite]
    
    var collectionView: UICollectionView
    
    let itemSize = UIScreen.main.bounds.width / 2
    let itemHeight = UIScreen.main.bounds.width / 2
    
    init(favoriteList: [MyFavorite], view: FriendDetailViewController) {
        self.favoriteList = favoriteList
        self.view = view
        
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 0.0
        flowLayout.itemSize = CGSize(width: self.itemSize, height: self.itemHeight)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(
            frame: CGRect(
                x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.itemHeight
            ),
            collectionViewLayout: flowLayout
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
        self.addSubview(self.collectionView)
    }
    
    private func configSubViews() {
        self.collectionView.register(FriendFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FriendFavoriteCollectionViewCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        
        self.collectionView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.autoSetDimension(.height, toSize: self.itemSize * 5)
        
        self.collectionView.autoPinEdge(toSuperviewEdge: .top)
        self.collectionView.autoPinEdge(toSuperviewEdge: .left)
        self.collectionView.autoPinEdge(toSuperviewEdge: .right)
        self.collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        self.collectionView.autoSetDimension(.height, toSize: self.itemSize * 5)
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
                image: UIImage(named: "sky"),
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
