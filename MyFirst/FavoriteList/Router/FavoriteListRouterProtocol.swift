import UIKit
protocol FavoriteListRouterProtocol {
    func displayAlert(_ alertController: UIAlertController)
    func displayFavoriteRegistrationView(title: String, index: Int, presenter: FavoriteListPresenterProtocol)
    func displayFavoriteDetailView(category: String, index: Int, favorite: MyFavorite, presenter: FavoriteListPresenterProtocol)
    func displayAlertForRegistrationView(_ alertController: UIAlertController, baseView: UIViewController)
}
