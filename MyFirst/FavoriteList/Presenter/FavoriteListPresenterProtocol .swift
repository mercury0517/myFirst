import UIKit

protocol FavoriteListPresenterProtocol {
    func editTopBannerButtonDidTap()
    func bannerImageSelected(image: UIImage)
    func favoriteCellDidTap(title: String, index: Int)
}
