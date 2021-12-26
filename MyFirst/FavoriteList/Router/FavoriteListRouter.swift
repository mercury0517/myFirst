import UIKit

class FavoriteListRouter: FavoriteListRouterProtocol {
    let view: FavoriteListViewControllerProtocol
    
    init(view: FavoriteListViewControllerProtocol) {
        self.view = view
    }
    
    func displayEditProfileView(
        userName: String, userIcon: UIImage?, topBanner: UIImage?, presenter: FavoriteListPresenterProtocol
    ) {
        let editProfileView = ProfileEditViewController(
            userName: userName, userIcon: userIcon, topBanner: topBanner, presenter: presenter
        )
        
        self.view.present(editProfileView)
    }
    
    func displayFavoriteRegistrationView(title: String, index: Int, presenter: FavoriteListPresenterProtocol) {
        // TODO: assmbleした方が良さそう
        let registrationView = FavoriteInputViewController(categoryName: title, itemIndex: index, presenter: presenter, isEdit: false)
        
        self.view.present(registrationView)
    }
    
    func displayFavoriteDetailView(category: String, index: Int, favorite: MyFavorite, presenter: FavoriteListPresenterProtocol) {
        let view = FavoriteDetailViewController(categoryName: category, itemIndex: index, favorite: favorite, presenter: presenter)
        
        self.view.present(view)
    }
    
    func displayFavoriteEditView(favorite: MyFavorite, presenter: FavoriteListPresenterProtocol) {
        let editView = FavoriteInputViewController(
            categoryName: favorite.categoryName, itemIndex: favorite.index, presenter: presenter, isEdit: true, favorite: favorite
        )
        
        self.topViewController()?.present(editView, animated: true)
    }
    
    // MARK: Alert
    func displayAlert(_ alertController: UIAlertController) {
        self.view.present(alertController)
    }
    
    func displayAlertForRegistrationView(_ alertController: UIAlertController, baseView: UIViewController) {
        baseView.present(alertController, animated: true)
    }
    
    private func topViewController() -> UIViewController? {
        var vc = UIApplication.shared.keyWindow?.rootViewController
        while vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        }
        return vc
    }
}
