import UIKit

class FavoriteListRouter: FavoriteListRouterProtocol {
    let view: FavoriteListViewControllerProtocol
    
    init(view: FavoriteListViewControllerProtocol) {
        self.view = view
    }
    
    func displayAlert(_ alertController: UIAlertController) {
        self.view.present(alertController)
    }
    
    func displayFavoriteRegistrationView(title: String, index: Int) {
        let registrationView = FavoriteRegistrationViewController(categoryName: title, itemIndex: index)
        
        self.view.present(registrationView)
    }
}
