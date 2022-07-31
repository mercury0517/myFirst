import UIKit

class CustomUIColor {
    static let turquoise = UIColor.rgba(red: 0, green: 183, blue: 206, alpha: 1) // #00b7ce
    static let background = UIColor.rgba(red: 179, green: 246, blue: 255, alpha: 1)
    static let lightBackground = UIColor.rgba(red: 211, green: 241, blue: 250, alpha: 1)
    static let customRed = UIColor.rgba(red: 238, green: 86, blue: 63, alpha: 1) // 238, 86, 63 #EE563F
    static let bloodOrange = UIColor.rgba(red: 218, green: 79, blue: 58, alpha: 1)// 218, 79, 58 #DA4F3A
}

extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
