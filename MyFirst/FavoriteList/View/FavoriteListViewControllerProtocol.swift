import UIKit

protocol FavoriteListViewControllerProtocol {
    var alertController: UIAlertController { get set }
    
    func present(_ viewController: UIViewController)
    func updateFavoriteList()
}
