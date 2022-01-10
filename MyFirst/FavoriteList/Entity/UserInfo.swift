import UIKit

class UserInfo: NSObject, NSCoding {
    let name: String
    var topBanner: UIImage?
    var icon: UIImage?
    var topBannerData: NSData?
    var iconData: NSData?
    
    init(name: String, topBanner: UIImage?, icon: UIImage?) {
        self.name = name
        self.topBanner = topBanner
        self.icon = icon
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.topBanner, forKey: "topBanner")
        coder.encode(self.icon, forKey: "icon")
        coder.encode(self.topBannerData, forKey: "topBannerData")
        coder.encode(self.iconData, forKey: "iconData")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as! String
        self.topBanner = coder.decodeObject(forKey: "topBanner") as? UIImage
        self.icon = coder.decodeObject(forKey: "icon") as? UIImage
        self.topBannerData = coder.decodeObject(forKey: "topBannerData") as? NSData
        self.iconData = coder.decodeObject(forKey: "iconData") as? NSData
    }
}
