import UIKit

// TODO: お気に入りにメモを持たせる
class MyFavorite: NSObject, NSCoding {
    let categoryName: String
    let index: Int
    let title: String
    let image: UIImage?
    var isCustomized: Bool
    
    init(categoryName: String, index: Int, title: String, image: UIImage?, isCustomized: Bool) {
        self.categoryName = categoryName
        self.index = index
        self.title = title
        self.image = image
        self.isCustomized = isCustomized
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.categoryName, forKey: "categoryName")
        coder.encode(self.index, forKey: "index")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.image, forKey: "image")
        coder.encode(self.isCustomized, forKey: "isCustomized")
    }
    
    required init?(coder: NSCoder) {
        self.categoryName = coder.decodeObject(forKey: "categoryName") as! String
        self.index = coder.decodeInteger(forKey: "index")
        self.title = coder.decodeObject(forKey: "title") as! String
        self.image = coder.decodeObject(forKey: "image") as? UIImage
        self.isCustomized = coder.decodeBool(forKey: "isCustomized")
    }
}
