import Foundation
import UIKit

class FavoriteListInteractor: FavoriteListInteractorProtocol {
    let userDefault = UserDefaults.standard
    
    func storeBannerImage(image: UIImage) {
        // 画像をuserDefaultに保存する時はNSDate型にする
        var saveArray: Array = [NSData]()
        
        if let imageData = image.pngData() as NSData? {
            saveArray.append(imageData)

            self.userDefault.set(saveArray, forKey: "bannerImage")
        }
    }
}
