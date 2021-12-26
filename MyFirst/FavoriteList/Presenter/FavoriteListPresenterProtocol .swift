import UIKit

protocol FavoriteListPresenterProtocol {
    // MARK: favorite list view
    func editProfileButtonDidTap(userName: String, userIcon: UIImage?, topBanner: UIImage?)
    func bannerImageSelected(image: UIImage)
    func favoriteCellDidTap(title: String, index: Int)
    func favoriteCellDidTapForDetail(category: String, index: Int, favorite: MyFavorite)
    // MARK: favorite input view
    func registerFavoriteButtonDidTap(favorite: MyFavorite, registrationView: FavoriteInputViewController)
    func updateFavoriteButtonDidTap(favorite: MyFavorite)
    // MARK: favorite detail view
    func deleteItemButtonDidTap(categoryName: String, itemIndex: Int, detailView: FavoriteDetailViewController)
    func editItemButtonDidTap(favorite: MyFavorite)
    // MARK: edit profile view
    func registerNewProfileButtonDidTap(userInfo: UserInfo, editProfileView: ProfileEditViewController)
}
