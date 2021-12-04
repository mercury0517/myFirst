import UIKit
class FavoriteListPresenter: FavoriteListPresenterProtocol {
    let view: FavoriteListViewProtocol
    let interactor: FavoriteListInteractorProtocol
    let router: FavoriteListRouterProtocol
    
    init(view: FavoriteListViewProtocol, interactor: FavoriteListInteractorProtocol, router: FavoriteListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func editTopBannerButtonDidTap() {
        self.router.displayAlert(self.view.alertController)
    }
    
    func bannerImageSelected(image: UIImage) {
        self.interactor.storeBannerImage(image: image)
    }
}
