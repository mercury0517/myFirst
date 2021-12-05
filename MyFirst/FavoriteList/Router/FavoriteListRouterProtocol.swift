import UIKit
protocol FavoriteListRouterProtocol {
    func displayAlert(_ alertController: UIAlertController)
    func displayFavoriteRegistrationView(title: String, index: Int, presenter: FavoriteListPresenterProtocol)
    func displayAlertForRegistrationView(_ alertController: UIAlertController, baseView: UIViewController)
}
