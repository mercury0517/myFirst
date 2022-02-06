import UIKit

class FriendDetailViewController: UIViewController {
    let uniqueKey: String
    let displayName: String
    var userInfo: UserInfo?
    
    let imageHeight = UIScreen.main.bounds.height * 0.2
    
    let scrollView = UIScrollView()
    
    let itemImageView = UIImageView(image: UIImage(named: "sky"))
    let closeButton = CustomCloseButton()
    
    let userIconView = UIImageView(image: UIImage(named: "sky"))
    
    let userNameLabel = UILabel()
    let separateLine = UIView()
    
    let favoriteGroupStackView = UIStackView()
    
    init(uniqueKey: String, displayName: String, userInfo: UserInfo?) {
        self.uniqueKey = uniqueKey
        self.displayName = displayName
        self.userInfo = userInfo
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.uniqueKey = ""
        self.displayName = ""
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
        
        self.displayFavoriteList()
        
        self.navigationItem.title = "\(self.displayName)"
    }
    
    func displayItemDetailView(favorite: MyFavorite) {
        self.present(
            FriendItemDetailViewController(favorite: favorite),
            animated: true
        )
    }
    
    private func displayFavoriteList() {
        var foodFavoriteList: [MyFavorite] = []
        var placeFavoriteList: [MyFavorite] = []
        var productFavoriteList: [MyFavorite] = []
        var personFavoriteList: [MyFavorite] = []
        var serviceFavoriteList: [MyFavorite] = []
        var sportsFavoriteList: [MyFavorite] = []
        var artistFavoriteList: [MyFavorite] = []
        var bookFavoriteList: [MyFavorite] = []
        var movieFavoriteList: [MyFavorite] = []
        var otherFavoriteList: [MyFavorite] = []
        
        // キャッシュからお気に入りを取り出して表示する
        if
            let archivedFavoriteList = UserDefaults.standard.object(forKey: self.uniqueKey) as? Data,
            let favoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedFavoriteList) as? [MyFavorite]
        {
            for favorite in favoriteList {
                // カテゴリ毎に配列に振り分ける
                switch favorite.categoryName {
                case FavoriteCategory.food.rawValue:
                    foodFavoriteList.append(favorite)
                case FavoriteCategory.place.rawValue:
                    placeFavoriteList.append(favorite)
                case FavoriteCategory.product.rawValue:
                    productFavoriteList.append(favorite)
                case FavoriteCategory.person.rawValue:
                    personFavoriteList.append(favorite)
                case FavoriteCategory.service.rawValue:
                    serviceFavoriteList.append(favorite)
                case FavoriteCategory.sports.rawValue:
                    sportsFavoriteList.append(favorite)
                case FavoriteCategory.artist.rawValue:
                    artistFavoriteList.append(favorite)
                case FavoriteCategory.book.rawValue:
                    bookFavoriteList.append(favorite)
                case FavoriteCategory.movie.rawValue:
                    movieFavoriteList.append(favorite)
                case FavoriteCategory.other.rawValue:
                    otherFavoriteList.append(favorite)
                default:
                    break
                }
            }
        } else {
            print("取得失敗")
        }
        
        // add stack view
        if !foodFavoriteList.isEmpty {
            let foodGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.food.rawValue, favoriteList: foodFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(foodGroupView)
            foodGroupView.autoPinEdge(toSuperviewEdge: .left)
            foodGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !placeFavoriteList.isEmpty {
            let placeGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.place.rawValue, favoriteList: placeFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(placeGroupView)
            placeGroupView.autoPinEdge(toSuperviewEdge: .left)
            placeGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !productFavoriteList.isEmpty {
            let productGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.product.rawValue, favoriteList: productFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(productGroupView)
            productGroupView.autoPinEdge(toSuperviewEdge: .left)
            productGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !personFavoriteList.isEmpty {
            let personGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.person.rawValue, favoriteList: personFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(personGroupView)
            personGroupView.autoPinEdge(toSuperviewEdge: .left)
            personGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !serviceFavoriteList.isEmpty {
            let serviceGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.service.rawValue, favoriteList: serviceFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(serviceGroupView)
            serviceGroupView.autoPinEdge(toSuperviewEdge: .left)
            serviceGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !sportsFavoriteList.isEmpty {
            let sportsGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.sports.rawValue, favoriteList: sportsFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(sportsGroupView)
            sportsGroupView.autoPinEdge(toSuperviewEdge: .left)
            sportsGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !artistFavoriteList.isEmpty {
            let artistGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.artist.rawValue, favoriteList: artistFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(artistGroupView)
            artistGroupView.autoPinEdge(toSuperviewEdge: .left)
            artistGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !bookFavoriteList.isEmpty {
            let bookGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.book.rawValue, favoriteList: bookFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(bookGroupView)
            bookGroupView.autoPinEdge(toSuperviewEdge: .left)
            bookGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !movieFavoriteList.isEmpty {
            let movieGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.movie.rawValue, favoriteList: movieFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(movieGroupView)
            movieGroupView.autoPinEdge(toSuperviewEdge: .left)
            movieGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
        
        if !otherFavoriteList.isEmpty {
            let otherGroupView = FriendFavoriteGroupView(
                title: FavoriteCategory.other.rawValue, favoriteList: otherFavoriteList, view: self
            )
            self.favoriteGroupStackView.addArrangedSubview(otherGroupView)
            otherGroupView.autoPinEdge(toSuperviewEdge: .left)
            otherGroupView.autoPinEdge(toSuperviewEdge: .right)
        }
    }

    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.itemImageView)
        self.scrollView.addSubview(self.closeButton)
        self.scrollView.addSubview(self.userIconView)
        self.scrollView.addSubview(self.userNameLabel)
        self.scrollView.addSubview(self.separateLine)
        self.scrollView.addSubview(self.favoriteGroupStackView)
    }
    
    private func configSubViews() {
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.clipsToBounds = true
        self.itemImageView.image = self.userInfo?.topBanner
        
        self.closeButton.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        
        self.userIconView.layer.cornerRadius = 50.0
        self.userIconView.contentMode = .scaleAspectFill
        self.userIconView.clipsToBounds = true
        self.userIconView.layer.borderWidth = 3.0
        self.userIconView.layer.borderColor = UIColor.white.cgColor
        self.userIconView.image = self.userInfo?.icon
        
        self.userNameLabel.text = self.userInfo?.name
        
        self.favoriteGroupStackView.axis = .vertical
        self.favoriteGroupStackView.spacing = 0.0
        self.favoriteGroupStackView.alignment = .center
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.userNameLabel.font = UIFont(name: "Oswald", size: 25.0)
        self.userNameLabel.textColor = .black
        
        self.separateLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.itemImageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        self.itemImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: self.imageHeight))
        
        self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        self.closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.userIconView.autoPinEdge(.top, to: .bottom, of: self.itemImageView, withOffset: -50.0)
        self.userIconView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.userIconView.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
        
        self.userNameLabel.autoPinEdge(.top, to: .bottom, of: self.userIconView, withOffset: 10.0)
        self.userNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.separateLine.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 1.0))
        self.separateLine.autoPinEdge(.top, to: .bottom, of: self.userNameLabel, withOffset: 20.0)
        self.separateLine.autoPinEdge(toSuperviewEdge: .left)
        self.separateLine.autoPinEdge(toSuperviewEdge: .right)
        
        self.favoriteGroupStackView.autoPinEdge(.top, to: .bottom, of: self.separateLine, withOffset: 20.0)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .right)
        self.favoriteGroupStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100.0)
        self.favoriteGroupStackView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
    }
    
    @objc private func tappedCloseButton() {
        self.dismiss(animated: true)
    }
}
