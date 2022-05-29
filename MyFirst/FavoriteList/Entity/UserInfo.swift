import UIKit

class UserInfo: NSObject, NSCoding {
    let name: String
    var topBanner: UIImage?
    var icon: UIImage?
    var favoriteDescription: String?
    
    init(name: String, topBanner: UIImage?, icon: UIImage?, favoriteDescription: String?) {
        self.name = name
        self.topBanner = topBanner
        self.icon = icon
        self.favoriteDescription = favoriteDescription
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.topBanner, forKey: "topBanner")
        coder.encode(self.icon, forKey: "icon")
        coder.encode(self.favoriteDescription, forKey: "favoriteDescription")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as! String
        self.topBanner = coder.decodeObject(forKey: "topBanner") as? UIImage
        self.icon = coder.decodeObject(forKey: "icon") as? UIImage
        self.favoriteDescription = coder.decodeObject(forKey: "favoriteDescription") as? String
    }
}
