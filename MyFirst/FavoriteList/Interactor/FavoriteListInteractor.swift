import Foundation
import UIKit
import Alamofire

class FavoriteListInteractor: FavoriteListInteractorProtocol {
    let userDefault = UserDefaults.standard
    
    func storeUserInfo(_ userInfo: UserInfo, completion: () -> Void) {
        let archivedUserInfo = try! NSKeyedArchiver.archivedData(withRootObject: userInfo, requiringSecureCoding: false)
        self.userDefault.set(archivedUserInfo, forKey: UserDefaultKeys.userInfo)
        
        completion()
    }
    
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
        // お気に入りを各カテゴリ1つしか持たなくなった為、上書きして保存するだけで良くなった。
        // 今後アイテムを複数持たせる場合は復活させる
        
//        var newFavoriteList: [MyFavorite] = []
//        var cachedFavoriteList = self.loadFavoriteList(categoryName: favorite.categoryName)
//
//        if !cachedFavoriteList.isEmpty {
//            // 3つまでしか登録できないので、3つに達していない場合のみ、要素を追加する
//            if cachedFavoriteList.count < 3 {
//                cachedFavoriteList.append(favorite)
//            } else {
//                // 既に3つ登録してある場合は、該当のindexの要素を差し替える
//                cachedFavoriteList[favorite.index] = favorite
//            }
//
//            newFavoriteList = cachedFavoriteList
//        } else {
//            // キャッシュがない場合は、初めてのお気に入りとして保存する
//            newFavoriteList.append(favorite)
//        }
        
        let archivedFavoriteList = try! NSKeyedArchiver.archivedData(withRootObject: [favorite], requiringSecureCoding: false)
        self.userDefault.set(archivedFavoriteList, forKey: favorite.categoryName)
    }
    
    func updateFavorite(_ favorite: MyFavorite) {
        // お気に入りを各カテゴリ1つしか持たなくなった為、上書きして保存するだけで良くなった。
        // 今後アイテムを複数持たせる場合は復活させる
        
//        var cachedFavoriteList = self.loadFavoriteList(categoryName: favorite.categoryName)
//
//        // 該当のindexのお気に入りを更新する
//        if !cachedFavoriteList.isEmpty {
//            cachedFavoriteList[favorite.index] = favorite
//        }
//
//        let archivedFavoriteList = try! NSKeyedArchiver.archivedData(withRootObject: cachedFavoriteList, requiringSecureCoding: false)
//        self.userDefault.set(archivedFavoriteList, forKey: favorite.categoryName)
        
        let archivedFavoriteList = try! NSKeyedArchiver.archivedData(withRootObject: [favorite], requiringSecureCoding: false)
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
    
    func deleteFavorite(categoryName: String, itemIndex: Int, completion: () -> Void) {
        // お気に入りを各カテゴリ1つしか持たなくなった為、キーの削除だけで良くなった。
        // 今後アイテムを複数持たせる場合は復活させる
        
//        let cachedFavoriteList = self.loadFavoriteList(categoryName: categoryName)
//        var newFavoriteList: [MyFavorite] = []
//        var newFavoriteCount = 0
//
//        // 削除対象のお気に入りのみ、新規リストには追加しない
//        for (index, favorite) in cachedFavoriteList.enumerated() {
//            if index != itemIndex {
//                favorite.index = newFavoriteCount // indexの上書き
//
//                newFavoriteList.append(favorite)
//                newFavoriteCount += 1
//            }
//        }
//
//        // 更新したお気に入りリストをキャッシュに再度登録する
//        let archivedFavoriteList = try! NSKeyedArchiver.archivedData(withRootObject: newFavoriteList, requiringSecureCoding: false)
//        self.userDefault.set(archivedFavoriteList, forKey: categoryName)
        
        self.userDefault.removeObject(forKey: categoryName)
        
        completion()
    }
    
}
