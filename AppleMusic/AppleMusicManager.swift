import UIKit
import Alamofire
import SwiftyJSON

class AppleMusicManager {
    // トークンの使用期限が切れているので、もし使う場合は再度トークンを発行する
    let header: HTTPHeaders = [
        "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6Ik0zOThaMlkyOUQifQ.eyJpc3MiOiJCUTlUQTVQR00yIiwiZXhwIjoxNjI3MDk3MTQ0LCJpYXQiOjE2MjcwMTA3NDR9.J4r3_nYZnAyraM5VAUJWK4n6HWseeHaDgluzKMQGIecpyuPGcwzk4_hZBf9htb_ojI8W8vfuY6LTR348youVvg"
    ]
    let baseUrlForSearch = "https://api.music.apple.com/v1/catalog/jp/search"
    let parametersForSearch = ["term": "bump of checken", "limit": "25", "types": "albums"]
    let userDefault = UserDefaults.standard
    
    func fetchAlbumIDList() {
        AF.request(
            self.baseUrlForSearch,
            method: .get,
            parameters: self.parametersForSearch,
            encoding: URLEncoding.default,
            headers: header
        ).responseJSON { responce in
            switch responce.result {
            case .success:
                if let object = responce.value {
                    let json = JSON(object)
                    let dataList = json["results"]["albums"]["data"]

                    // TODO: jsonをfor文で回すと要素の取得が上手く出来ない
                    var albumIDList: [String] = []
                    for (index, _) in dataList.enumerated() {
                        if let unwrappedID = dataList[index]["id"].rawValue as? String {
                            albumIDList.append(unwrappedID)
                        }
                    }
                    
                    // 非同期処理なのでreturn出来ず、キャッシュに保存する様にした
                    self.userDefault.setValue(albumIDList, forKey: "albumIDList")
                }
            case .failure(let error):
                print("エラーだよ\(error)")
            }
        }
    }
}
