import UIKit

class CustomUIColor {
    static let turquoise = UIColor.rgba(red: 0, green: 183, blue: 206, alpha: 1)
    static let background = UIColor.rgba(red: 179, green: 246, blue: 255, alpha: 1)
}

extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
