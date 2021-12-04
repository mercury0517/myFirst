import UIKit
import PureLayout

/*
 TODO1: VIPER化する
 TODO2: バナー画像の差し替えを差し替えられる様にする
 TODO3: 新規カテゴリを追加できる様にする
 TODO4: 既存カテゴリを編集できる様にする
 TODO5: 既存カテゴリの右に追加ボタンを置く、ただし1カテゴリ3個までしか登録させない
*/
class FavoriteListViewController: UIViewController{
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    let topBanner = UIImageView(image: UIImage(named: "flight_banner"))
    let favoriteGroupStackView = UIStackView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
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
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.topBanner)
        self.scrollView.addSubview(self.favoriteGroupStackView)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "MY FAVORITE"

        self.topBanner.backgroundColor = .black
        self.topBanner.contentMode = .scaleToFill
        
        self.favoriteGroupStackView.alignment = .center
        self.favoriteGroupStackView.axis = .vertical
        self.favoriteGroupStackView.spacing = 10.0
        
        // custom favorite groups
        let favoriteGroup1 = FavoriteGroupView(title: "ARTIST")
        let favoriteGroup2 = FavoriteGroupView(title: "ALBUM")
        let favoriteGroup3 = FavoriteGroupView(title: "PLACE")
        
        self.favoriteGroupStackView.addArrangedSubview(favoriteGroup1)
        favoriteGroup1.autoPinEdge(toSuperviewEdge: .left)
        favoriteGroup1.autoPinEdge(toSuperviewEdge: .right)
        
        self.favoriteGroupStackView.addArrangedSubview(favoriteGroup2)
        favoriteGroup2.autoPinEdge(toSuperviewEdge: .left)
        favoriteGroup2.autoPinEdge(toSuperviewEdge: .right)
        
        self.favoriteGroupStackView.addArrangedSubview(favoriteGroup3)
        favoriteGroup3.autoPinEdge(toSuperviewEdge: .left)
        favoriteGroup3.autoPinEdge(toSuperviewEdge: .right)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 20.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 40.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.topBanner.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 20.0)
        self.topBanner.autoPinEdge(toSuperviewEdge: .left)
        self.topBanner.autoPinEdge(toSuperviewEdge: .right)
        self.topBanner.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 250.0))
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.topBanner, withOffset: 20.0)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .right)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
    }
}

