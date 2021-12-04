class FavoriteListPresenter: FavoriteListPresenterProtocol {
    let view: FavoriteListViewProtocol
    let router: FavoriteListRouterProtocol
    
    init(view: FavoriteListViewProtocol, router: FavoriteListRouterProtocol) {
        self.view = view
        self.router = router
    }
}
