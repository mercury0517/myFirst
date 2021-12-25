import UIKit

protocol FavoriteListInteractorProtocol {
    func storeUserInfo(_ userInfo: UserInfo, completion: () -> Void)
    func storeBannerImage(image: UIImage)
    func storeFavorite(_ favorite: MyFavorite)
    func loadFavoriteList(categoryName: String) -> [MyFavorite]
    func deleteFavorite(categoryName: String, itemIndex: Int, completion: () -> Void)
}
