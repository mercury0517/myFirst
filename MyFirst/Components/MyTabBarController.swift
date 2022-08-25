import UIKit
import AudioToolbox

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    let tabView1 = AppDependencies.assmbleFavoriteList()
    let tabView2 = CustomNavigationController(rootViewController: GalleryViewController())
    let tabView3 = CustomNavigationController(rootViewController: ExchangeViewController())
    let tabView4 = CustomNavigationController(rootViewController: FriendListViewController())
    let tabView5 = CustomNavigationController(rootViewController: MoreInformationViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabView1.tabBarItem.title = "FAVORITE"
        self.tabView1.tabBarItem.image = UIImage(named: "tab_home")
        self.tabView1.tabBarItem.tag = 1
        
        self.tabView2.tabBarItem.title = "GALLERY"
        self.tabView2.tabBarItem.image = UIImage(named: "tab_gallery")
        self.tabView2.tabBarItem.tag = 2
        
        self.tabView3.tabBarItem.title = ""
        self.tabView3.tabBarItem.image = UIImage(named: "center_scopp")?.withRenderingMode(.alwaysOriginal)
        self.tabView3.tabBarItem.tag = 3
        
        self.tabView4.tabBarItem.title = "FRIEND"
        self.tabView4.tabBarItem.image = UIImage(named: "tab_video")
        self.tabView4.tabBarItem.tag = 4
        
        self.tabView5.tabBarItem.title = "OTHER"
        self.tabView5.tabBarItem.image = UIImage(named: "tab_photo")
        self.tabView5.tabBarItem.tag = 5
        
        let contentsList : Array<UIViewController> = [
            self.tabView1, self.tabView2, self.tabView3, self.tabView4, self.tabView5
        ]
        self.setViewControllers(contentsList, animated: false)
        
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
            // ハプティックフィードバックを入れる
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
        
        self.lastSelectedIndex = item.tag
    }
    
    private func configTabView() {
        UITabBar.appearance().backgroundColor = CustomUIColor.lightBackground
        UITabBar.appearance().tintColor = CustomUIColor.turquoise
        self.tabBar.shadowImage = UIImage(named: "sky")
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  CustomUIColor.lightBackground
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
