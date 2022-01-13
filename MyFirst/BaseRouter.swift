import UIKit

class BaseRouter {
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func displayTabBarController() {
        self.window?.rootViewController = MyTabBarController()
    }
}
