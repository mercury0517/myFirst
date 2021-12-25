import UIKit

protocol FavoriteListPresenterProtocol {
    // MARK: favorite List view
    func editProfileButtonDidTap(userName: String, userIcon: UIImage?, topBanner: UIImage?)
    func bannerImageSelected(image: UIImage)
    func favoriteCellDidTap(title: String, index: Int)
    func favoriteCellDidTapForDetail(category: String, index: Int, favorite: MyFavorite)
    // MARK: favorite registeration view
    func registerFavoriteButtonDidTap(favorite: MyFavorite, registrationView: FavoriteRegistrationViewController)
    // MARK: favorite detail view
    func deleteItemButtonDidTap(categoryName: String, itemIndex: Int, detailView: FavoriteDetailViewController)
    // MARK: edit profile view
    func registerNewProfileButtonDidTap(userInfo: UserInfo, editProfileView: ProfileEditViewController)
}
