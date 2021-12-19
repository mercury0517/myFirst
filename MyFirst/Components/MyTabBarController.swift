import UIKit

class MyTabBarController: UITabBarController {
    let tabView1 = AppDependencies.assmbleFavoriteList()
    let tabView2 = VideoViewController()
    let tabView3 = HomeViewController()
    let tabView4 = PhotoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView1.tabBarItem.title = "MY FAV"
        tabView1.tabBarItem.image = UIImage(named: "tab_home")
        tabView1.tabBarItem.tag = 1
        
        tabView2.tabBarItem.title = "FRIEND"
        tabView2.tabBarItem.image = UIImage(named: "tab_video")
        tabView2.tabBarItem.tag = 2
        
        tabView3.tabBarItem.title = "EXCHENGE"
        tabView3.tabBarItem.image = UIImage(named: "tab_cd")
        tabView3.tabBarItem.tag = 3
        
        tabView4.tabBarItem.title = "MORE"
        tabView4.tabBarItem.image = UIImage(named: "tab_photo")
        tabView4.tabBarItem.tag = 4
        
        let conList : Array<UIViewController> = [tabView1, tabView2, tabView3, tabView4]
        self.setViewControllers(conList, animated: false)
        
        self.configTabView()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // tabタップしたらやりたいこと
        switch item.tag {
        case 1:
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
    }
    
    private func configTabView() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .red
        
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
