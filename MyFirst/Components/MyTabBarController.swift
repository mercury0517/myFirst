import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    let tabView1 = AppDependencies.assmbleFavoriteList()
    let tabView2 = CustomNavigationController(rootViewController: FriendListViewController())
    let tabView3 = CustomNavigationController(rootViewController: ExchangeViewController())
    let tabView4 = PhotoViewController()
    
    var shouldScroll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabView1.tabBarItem.title = "お気に入り"
        self.tabView1.tabBarItem.image = UIImage(named: "tab_home")
        self.tabView1.tabBarItem.tag = 1
        
        self.tabView2.tabBarItem.title = "友達"
        self.tabView2.tabBarItem.image = UIImage(named: "tab_video")
        self.tabView2.tabBarItem.tag = 2
        
        self.tabView3.tabBarItem.title = "交換"
        self.tabView3.tabBarItem.image = UIImage(named: "tab_cd")
        self.tabView3.tabBarItem.tag = 3
        
        self.tabView4.tabBarItem.title = "その他"
        self.tabView4.tabBarItem.image = UIImage(named: "tab_photo")
        self.tabView4.tabBarItem.tag = 5
        
        let conList : Array<UIViewController> = [tabView1, tabView2, tabView3, tabView4]
        self.setViewControllers(conList, animated: false)
        
        self.configTabView()
    }
    
    var lastSelectedIndex = 0
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // tabタップしたらやりたいこと
        switch item.tag {
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
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  UIColor.white
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
