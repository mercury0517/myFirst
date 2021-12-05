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
    
    // カテゴリ名をキーにして、お気に入りを配列で保存する
    func storeFavorite(_ favorite: MyFavorite) {
        var newFavoriteList: [MyFavorite] = []
        
        var cachedFavoriteList = self.loadFavoriteList(categoryName: favorite.categoryName)
        
        if !cachedFavoriteList.isEmpty {
            // 3つまでしか登録できないので、3つに達していない場合のみ、要素を追加する
            if cachedFavoriteList.count < 3 {
                cachedFavoriteList.append(favorite)
            } else {
                // 既に3つ登録してある場合は、該当のindexの要素を差し替える
                cachedFavoriteList[favorite.index] = favorite
            }
            
            newFavoriteList = cachedFavoriteList
        } else {
            // キャッシュがない場合は、初めてのお気に入りとして保存する
            newFavoriteList.append(favorite)
        }
        
        let archivedFavoriteList = try! NSKeyedArchiver.archivedData(withRootObject: newFavoriteList, requiringSecureCoding: false)
        self.userDefault.set(archivedFavoriteList, forKey: favorite.categoryName)
    }
    
    func loadFavoriteList(categoryName: String) -> [MyFavorite] {
        // そのカテゴリ名でお気に入りを保存していれば、それを配列で返却する
        if
            let data = self.userDefault.object(forKey: categoryName) as? Data,
            let favoriteList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MyFavorite]
        {
            return favoriteList
        } else {
            return []
        }
    }
}
