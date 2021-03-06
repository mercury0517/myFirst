import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    let tabView1 = AppDependencies.assmbleFavoriteList()
    let tabView2 = CustomNavigationController(rootViewController: FriendListViewController())
    let tabView3 = CustomNavigationController(rootViewController: ExchangeViewController())
    let tabView4 = CustomNavigationController(rootViewController: MoreInformationViewController())
    
    var shouldScroll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabView1.tabBarItem.title = "FAVORITE"
        self.tabView1.tabBarItem.image = UIImage(named: "tab_home")
        self.tabView1.tabBarItem.tag = 1
        
        self.tabView2.tabBarItem.title = "FRIEND"
        self.tabView2.tabBarItem.image = UIImage(named: "tab_video")
        self.tabView2.tabBarItem.tag = 2
        
        self.tabView3.tabBarItem.title = "EXCHANGE"
        self.tabView3.tabBarItem.image = UIImage(named: "tab_cd")
        self.tabView3.tabBarItem.tag = 3
        
        self.tabView4.tabBarItem.title = "OTHER"
        self.tabView4.tabBarItem.image = UIImage(named: "tab_photo")
        self.tabView4.tabBarItem.tag = 5
        
        let conList : Array<UIViewController> = [tabView1, tabView2, tabView3, tabView4]
        self.setViewControllers(conList, animated: false)
        
        self.configTabView()
        
        // シングルトンに高さを保存
        TabBarHeightManager.shared.height = self.tabBar.frame.size.height
    }
    
    var lastSelectedIndex = 0
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // tabタップしたらやりたいこと
        switch item.tag {
        // タブを2連続タップした時にスクロールトップしたい
        case 1:
            if
                let navigationController = tabView1 as? UINavigationController,
                let favoriteListView = navigationController.viewControllers.first as? FavoriteListViewController,
                item.tag == self.lastSelectedIndex // homeタブを2連続でタップしていたら
            {
                favoriteListView.scrollToTop()
            }
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
        
        self.lastSelectedIndex = item.tag
    }
    
    private func configTabView() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = CustomUIColor.turquoise
        self.tabBar.shadowImage = UIImage(named: "sky")
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  .white
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }

        UITabBarItem.appearance().setTitleTextAttributes(
            [.font : UIFont.init(name: "HelveticaNeue-Medium", size: 15.0) ?? "", .foregroundColor : UIColor.black],
            for: .selected
        )
    }
}

class TabBarHeightManager {
    var height: CGFloat = 0

    static let shared = TabBarHeightManager()
    
    private init() {}
}
