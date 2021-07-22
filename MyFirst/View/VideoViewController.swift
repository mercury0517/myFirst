import UIKit
import PureLayout

class VideoViewController: UIViewController {
    let titleLabel = UILabel()
    var collectionView: UICollectionView
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 16.0
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48.0) / 2, height: 140.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300.0), collectionViewLayout: flowLayout
        )
        
        super.init(nibName: nil, bundle: nil)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 16.0
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48.0) / 2, height: 140.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300.0), collectionViewLayout: flowLayout
        )
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.collectionView)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "VIDEOS"
        
        self.collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "VideoCollectionViewCell")
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 20.0)
        
        self.collectionView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.collectionView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 15.0)
        self.collectionView.autoPinEdge(toSuperviewEdge: .left)
        self.collectionView.autoPinEdge(toSuperviewEdge: .right)
        self.collectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
}

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VideoType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        
        cell.image =  VideoType.allCases[indexPath.row].getImage()
        cell.title = VideoType.allCases[indexPath.row].getTitle()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}
