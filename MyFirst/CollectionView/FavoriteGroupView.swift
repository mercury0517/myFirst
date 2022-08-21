import UIKit

class FavoriteGroupView: UIView {
    var presenter: FavoriteListPresenterProtocol?
    
    var countOfItem: Int = 0
    
    var collectionView: UICollectionView
    
    let itemSize = UIScreen.main.bounds.width / 2
    let itemHeight = UIScreen.main.bounds.width / 2
    
    init(presenter: FavoriteListPresenterProtocol?) {
        self.presenter = presenter
        
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
        self.collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
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

extension FavoriteGroupView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let favoriteCategory = FavoriteCategory.allCases[indexPath.row]
        
        if
            let data = UserDefaults.standard.object(forKey: favoriteCategory.rawValue) as? Data,
            let cachedFavoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite],
            let targetFavorite = cachedFavoriteList.first
        {
            cell.favorite = MyFavorite(
                categoryName: targetFavorite.categoryName,
                index: targetFavorite.index,
                title: targetFavorite.title,
                image: targetFavorite.image,
                memo: targetFavorite.memo,
                isCustomized: true
            )
        } else {
            // 追加セルとして表示
            cell.favorite = MyFavorite(
                categoryName: "",
                index: indexPath.row,
                title: "",
                image: UIImage(named: "add_icon"),
                memo: nil,
                isCustomized: false
            )
        }
        
        // キャッシュからそのカテゴリのお気に入りを取得する
//        if
//            let data = UserDefaults.standard.object(forKey: self.title) as? Data,
//            let cachedFavoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite]
//
//        {
//            let targetFavorite = cachedFavoriteList[indexPath.row]
//
//            cell.favorite = MyFavorite(
//                categoryName: targetFavorite.categoryName,
//                index: targetFavorite.index,
//                title: targetFavorite.title,
//                image: targetFavorite.image,
//                memo: targetFavorite.memo,
//                isCustomized: true
//            )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FavoriteCollectionViewCell
        let favoriteCategory = FavoriteCategory.allCases[indexPath.row]
        
        // アイテムが未設定なら登録画面を開く、そうでなければ編集画面を開く
        if let favorite = cell?.favorite {
            if favorite.isCustomized {
                // 詳細画面に遷移させる
                self.presenter?.favoriteCellDidTapForDetail(category: favoriteCategory.rawValue, index: indexPath.row, favorite: favorite)
            } else {
                // 新規追加画面に遷移させる
                self.presenter?.favoriteCellDidTap(title: favoriteCategory.rawValue, index: indexPath.row)
            }
        }
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
