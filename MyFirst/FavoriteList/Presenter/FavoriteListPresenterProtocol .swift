import UIKit

protocol FavoriteListPresenterProtocol {
    // MARK: favorite List view
    func editTopBannerButtonDidTap()
    func bannerImageSelected(image: UIImage)
    func favoriteCellDidTap(title: String, index: Int)
    // MARK: favorite registeration view
    func registerFavoriteButtonDidTap(favorite: MyFavorite, registrationView: FavoriteRegistrationViewController)
}
