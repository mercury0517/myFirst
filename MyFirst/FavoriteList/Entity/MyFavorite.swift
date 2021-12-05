import UIKit

class MyFavorite: NSObject, NSCoding {
    let categoryName: String
    let index: Int
    let title: String
    let image: UIImage?
    
    init(categoryName: String, index: Int, title: String, image: UIImage?) {
        self.categoryName = categoryName
        self.index = index
        self.title = title
        self.image = image
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.categoryName, forKey: "categoryName")
        coder.encode(self.index, forKey: "index")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.image, forKey: "image")
    }
    
    required init?(coder: NSCoder) {
        self.categoryName = coder.decodeObject(forKey: "categoryName") as! String
        self.index = coder.decodeInteger(forKey: "index")
        self.title = coder.decodeObject(forKey: "title") as! String
        self.image = coder.decodeObject(forKey: "image") as? UIImage
    }
}
