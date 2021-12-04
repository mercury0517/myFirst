import UIKit

protocol FavoriteListViewProtocol {
    var alertController: UIAlertController { get set }
    
    func present(_ viewController: UIViewController)
}
