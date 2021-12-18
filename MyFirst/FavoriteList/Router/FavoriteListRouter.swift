import UIKit

class FavoriteListRouter: FavoriteListRouterProtocol {
    let view: FavoriteListViewControllerProtocol
    
    init(view: FavoriteListViewControllerProtocol) {
        self.view = view
    }
    
    func displayAlert(_ alertController: UIAlertController) {
        self.view.present(alertController)
    }
    
    func displayFavoriteRegistrationView(title: String, index: Int, presenter: FavoriteListPresenterProtocol) {
        // TODO: assmbleした方が良さそう
        let registrationView = FavoriteRegistrationViewController(categoryName: title, itemIndex: index, presenter: presenter)
        
        self.view.present(registrationView)
    }
    
    func displayFavoriteDetailView(category: String, index: Int, favorite: MyFavorite, presenter: FavoriteListPresenterProtocol) {
        let view = FavoriteDetailViewController(categoryName: category, itemIndex: index, favorite: favorite, presenter: presenter)
        
        self.view.present(view)
    }
    
    func displayAlertForRegistrationView(_ alertController: UIAlertController, baseView: UIViewController) {
        baseView.present(alertController, animated: true)
    }
}
