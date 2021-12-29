import AudioToolbox
import UIKit

class FavoriteListPresenter: FavoriteListPresenterProtocol {
    let view: FavoriteListViewControllerProtocol
    let interactor: FavoriteListInteractorProtocol
    let router: FavoriteListRouterProtocol
    
    private lazy var impactFeedback: Any? = {
        let generator: UIFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        return generator
    }()
    
    init(view: FavoriteListViewControllerProtocol, interactor: FavoriteListInteractorProtocol, router: FavoriteListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: favorite list view
    func editProfileButtonDidTap(userName: String, userIcon: UIImage?, topBanner: UIImage?) {
        self.router.displayEditProfileView(
            userName: userName, userIcon: userIcon, topBanner: topBanner, presenter: self
        )
    }
    
    func bannerImageSelected(image: UIImage) {
        self.interactor.storeBannerImage(image: image)
    }
    
    func favoriteCellDidTap(title: String, index: Int) {
        self.router.displayFavoriteRegistrationView(title: title, index: index, presenter: self)
    }
    
    func favoriteCellDidTapForDetail(category: String, index: Int, favorite: MyFavorite) {
        self.router.displayFavoriteDetailView(category: category, index: index, favorite: favorite, presenter: self)
    }
    
    // MARK: favorite input view
    func registerFavoriteButtonDidTap(favorite: MyFavorite, registrationView: FavoriteInputViewController) {
        self.interactor.storeFavorite(favorite)
        // ハプティックフィードバックを入れる
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        self.view.updateFavoriteList()
        registrationView.dismiss(animated: true)
    }
    
    func updateFavoriteButtonDidTap(favorite: MyFavorite) {
        self.interactor.updateFavorite(favorite)
        // ハプティックフィードバックを入れる
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        self.view.updateFavoriteList()
        self.view.dismissToHome()
    }
    
    // MARK: favorite detail view
    func deleteItemButtonDidTap(
        categoryName: String, itemIndex: Int, detailView: FavoriteDetailViewController
    ) {
        self.interactor.deleteFavorite(categoryName: categoryName, itemIndex: itemIndex) {
            // ハプティックフィードバックを入れる
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            self.view.updateFavoriteList()
            detailView.dismiss(animated: true)
        }
    }
    
    func editItemButtonDidTap(favorite: MyFavorite) {
        self.router.displayFavoriteEditView(favorite: favorite, presenter: self)
    }
    
    // MARK: edit profile view
    func registerNewProfileButtonDidTap(userInfo: UserInfo, editProfileView: ProfileEditViewController) {
        self.interactor.storeUserInfo(userInfo) {
            // ハプティックフィードバックを入れる
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            self.view.updateFavoriteList()
            editProfileView.dismiss(animated: true)
        }
    }
}
