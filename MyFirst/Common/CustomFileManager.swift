import Foundation
import UIKit

class CustomFileManager {
    func saveGalleryFavorite(key: String, title: String, image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try title.write(to: self.getFileURL(fileName: "\(key).txt"), atomically: true, encoding: .utf8) // タイトルの書き込み
            try imageData.write(to: self.getFileURL(fileName: "\(key).jpg")) // 画像の書き込み
            
            // ユニークキーはUserDefaults上で管理する。
            self.storeFavoriteKeyToUserDefaults(key: key)
        } catch {
            // 保存できなかった場合は、UserDefaultsからもKeyを削除する
            self.deleteFavoriteKeyToUserDefaults(key: key)
            
            print("fail to save image")
        }
    }
    
    // 引数に渡したファイル名を含む形でURLを返却する
    private func getFileURL(fileName: String) -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    private func storeFavoriteKeyToUserDefaults(key: String) {
        let cachedKeyList = UserDefaults.standard.object(forKey: UserDefaultKeys.galleryFavoriteKeyList) as? [String]
        
        var newKeyList: [String] = []
        if let unwrappedCachedKeyList = cachedKeyList {
            newKeyList = unwrappedCachedKeyList
        }
        
        newKeyList.append(key)
        UserDefaults.standard.set(newKeyList, forKey: UserDefaultKeys.galleryFavoriteKeyList)
    }
    
    private func deleteFavoriteKeyToUserDefaults(key: String) {
        let cachedKeyList = UserDefaults.standard.object(forKey: UserDefaultKeys.galleryFavoriteKeyList) as? [String]
        
        var newKeyList: [String] = []
        if let unwrappedCachedKeyList = cachedKeyList {
            for cachedKey in unwrappedCachedKeyList {
                // 引数のキーのもの以外を追加する(=指定したキーをUserDefaultsから削除する)
                if cachedKey != key {
                    newKeyList.append(cachedKey)
                }
            }
            
            UserDefaults.standard.set(newKeyList, forKey: UserDefaultKeys.galleryFavoriteKeyList)
        }
    }
}
