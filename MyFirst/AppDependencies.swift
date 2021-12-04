class AppDependencies {
    static func assmbleFavoriteList() -> FavoriteListViewController {
        let view = FavoriteListViewController()
        let router = FavoriteListRouter(view: view)
        let interactor = FavoriteListInteractor()
        let presenter = FavoriteListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
}
