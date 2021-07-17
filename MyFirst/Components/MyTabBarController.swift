import UIKit

class MyTabBarController: UITabBarController {
    let tabView1 = HomeViewController()
    let tabView2 = VideoViewController()
    let tabView3 = ThirdViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView1.tabBarItem.title = "HOME"
        tabView1.tabBarItem.tag = 1
        
        tabView2.tabBarItem.title = "VIDEOS"
        tabView2.tabBarItem.tag = 2
        
        tabView3.tabBarItem.title = "DISCOGRAPHY"
        tabView3.tabBarItem.tag = 3
        
        let conList : Array<UIViewController> = [tabView1, tabView2, tabView3]
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
        default:
            break
        }
    }
    
    private func configTabView() {
        UITabBar.appearance().tintColor = .black

        UITabBarItem.appearance().setTitleTextAttributes(
            [.font : UIFont.init(name: "HelveticaNeue-Medium", size: 15.0) ?? "", .foregroundColor : UIColor.red],
            for: .selected
        )
    }
}
