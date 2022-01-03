import UIKit

class FriendDetailViewController: UIViewController {
    let uniqueKey: String
    
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    
    init(uniqueKey: String) {
        self.uniqueKey = uniqueKey
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.uniqueKey = ""
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        self.displayFavoriteList()
    }
    
    private func displayFavoriteList() {
        // キャッシュからお気に入りを取り出して表示する
        if
            let archivedFavoriteList = UserDefaults.standard.object(forKey: self.uniqueKey) as? Data,
            let favoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedFavoriteList) as? [MyFavorite]
        {
            for favorite in favoriteList {
                print("お気に入りのタイトル\(favorite.title)")
                print("お気に入りの画像\(favorite.image)")
                print("お気に入りのカテゴリ\(favorite.categoryName)")
            }
        } else {
            print("取得失敗")
        }
    }

    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "お気に入りを出す"
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 15.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.titleLabel.autoCenterInSuperview()
    }
}
