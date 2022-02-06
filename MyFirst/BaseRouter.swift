import UIKit

class BaseRouter {
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func displayTabBarController() {
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.isAlredayLaunch) {
            self.window?.rootViewController = MyTabBarController()
        } else {
            // 初回起動時はこちらに遷移して、名前を登録させる
            self.window?.rootViewController = CustomNavigationController(
                rootViewController: FirstRegisterViewController(window: self.window)
            )
        }

    }
}
