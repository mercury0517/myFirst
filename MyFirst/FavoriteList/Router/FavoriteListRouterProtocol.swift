import UIKit
protocol FavoriteListRouterProtocol {
    func displayEditProfileView(
        userName: String, userIcon: UIImage?, topBanner: UIImage?, presenter: FavoriteListPresenterProtocol
    )
    func displayFavoriteRegistrationView(title: String, index: Int, presenter: FavoriteListPresenterProtocol)
    func displayFavoriteDetailView(category: String, index: Int, favorite: MyFavorite, presenter: FavoriteListPresenterProtocol)
    func displayFavoriteEditView(favorite: MyFavorite, presenter: FavoriteListPresenterProtocol)
    // MARK: Alert
    func displayAlert(_ alertController: UIAlertController)
    func displayAlertForRegistrationView(_ alertController: UIAlertController, baseView: UIViewController)
}
