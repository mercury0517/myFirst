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
    
    // MARK: favorite List view
    func editTopBannerButtonDidTap() {
        self.router.displayAlert(self.view.alertController)
    }
    
    func bannerImageSelected(image: UIImage) {
        self.interactor.storeBannerImage(image: image)
    }
    
    func favoriteCellDidTap(title: String, index: Int) {
        // タップしたアイテムが
        self.router.displayFavoriteRegistrationView(title: title, index: index, presenter: self)
    }
    
    // MARK: favorite registeration view
    func registerFavoriteButtonDidTap(favorite: MyFavorite, registrationView: FavoriteRegistrationViewController) {
        self.interactor.storeFavorite(favorite)
        
        self.view.updateFavoriteList()
        
        registrationView.dismiss(animated: true)
    }
}
