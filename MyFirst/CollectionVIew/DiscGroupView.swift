import UIKit

class DiscGroupView: UIView {
    let discType: DiscType
    
    let titleLabel = UILabel()
    var collectionView: UICollectionView
    
    init(discType: DiscType) {
        self.discType = discType
        
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 16.0
        flowLayout.itemSize = CGSize(width: 150.0, height: 180.0)
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
        case .album:
            self.titleLabel.text = "アルバム"
        case .single:
            self.titleLabel.text = "シングル"
        }
        
        self.collectionView.register(DiscCollectionViewCell.self, forCellWithReuseIdentifier: "DiscCollectionViewCell")
    }
    
    private func applyStyling() {
        self.backgroundColor = .white
        
        self.titleLabel.textColor = .red
        self.titleLabel.font = .boldSystemFont(ofSize: 15.0)
        
        self.collectionView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.autoSetDimension(.height, toSize: 210.0)
        
        self.titleLabel.autoSetDimension(.height, toSize: 30.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right)
        
        self.collectionView.autoPinEdge(.top, to: .bottom, of: self.titleLabel)
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
        case .album:
            return 10
        case .single:
            return SingleDisc.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DiscCollectionViewCell", for: indexPath) as! DiscCollectionViewCell
        
        switch self.discType {
        case .album:
            cell.compactDisc = CompactDisc(title: "アカシア", artwork: UIImage(named: "single_acacia"))
        case .single:
            cell.compactDisc = SingleDisc.allCases[indexPath.row].getDisc()
        }
        
        return cell
    }
}
