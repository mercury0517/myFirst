class AppDependencies {
    static func assmbleFavoriteList() -> FavoriteListViewController {
        let view = FavoriteListViewController()
        let router = FavoriteListRouter()
        let presenter = FavoriteListPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
}
