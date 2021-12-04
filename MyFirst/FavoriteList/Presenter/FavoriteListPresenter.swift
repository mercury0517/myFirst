import UIKit
class FavoriteListPresenter: FavoriteListPresenterProtocol {
    let view: FavoriteListViewControllerProtocol
    let interactor: FavoriteListInteractorProtocol
    let router: FavoriteListRouterProtocol
    
    init(view: FavoriteListViewControllerProtocol, interactor: FavoriteListInteractorProtocol, router: FavoriteListRouterProtocol) {
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
    
    func favoriteCellDidTap(title: String, index: Int) {
        self.router.displayFavoriteRegistrationView(title: title, index: index)
    }
}
