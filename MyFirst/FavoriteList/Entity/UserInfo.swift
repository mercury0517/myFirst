import UIKit

class UserInfo: NSObject, NSCoding {
    let name: String
    let topBanner: UIImage?
    let icon: UIImage?
    
    init(name: String, topBanner: UIImage?, icon: UIImage?) {
        self.name = name
        self.topBanner = topBanner
        self.icon = icon
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.topBanner, forKey: "topBanner")
        coder.encode(self.icon, forKey: "icon")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as! String
        self.topBanner = coder.decodeObject(forKey: "topBanner") as? UIImage
        self.icon = coder.decodeObject(forKey: "icon") as? UIImage
    }
}
