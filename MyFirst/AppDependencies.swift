import UIKit
class AppDependencies {
    static func assmbleFavoriteList() -> UIViewController {
        let view = FavoriteListViewController()
        let router = FavoriteListRouter(view: view)
        let interactor = FavoriteListInteractor()
        let presenter = FavoriteListPresenter(view: view, interactor: interactor, router: router)
        
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
