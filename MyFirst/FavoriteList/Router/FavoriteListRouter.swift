import UIKit

class FavoriteListRouter: FavoriteListRouterProtocol {
    let view: FavoriteListViewProtocol
    
    init(view: FavoriteListViewProtocol) {
        self.view = view
    }
    
    func displayAlert(_ alertController: UIAlertController) {
        self.view.present(alertController)
    }
}
