import UIKit

class DiscGroupView: UIView {
    let discType: DiscType
    
    let titleLabel = UILabel()
    var collectionView: UICollectionView
    
    init(discType: DiscType) {
        self.discType = discType
        
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
        switch self.discType {
        case .new:
            break
        case .album:
            self.titleLabel.text = "ALBUM"
        case .single:
            self.titleLabel.text = "SINGLE"
        }
        
        self.collectionView.register(DiscCollectionViewCell.self, forCellWithReuseIdentifier: "DiscCollectionViewCell")
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

extension DiscGroupView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.discType {
        case .new:
            return NewDisc.allCases.count
        case .album:
            return AlbumDisc.allCases.count
        case .single:
            return SingleDisc.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DiscCollectionViewCell", for: indexPath) as! DiscCollectionViewCell
        
        switch self.discType {
        case .new:
            cell.compactDisc = NewDisc.allCases[indexPath.row].getDisc()
        case .album:
            cell.compactDisc = AlbumDisc.allCases[indexPath.row].getDisc()
        case .single:
            cell.compactDisc = SingleDisc.allCases[indexPath.row].getDisc()
        }
        
        return cell
    }
}
