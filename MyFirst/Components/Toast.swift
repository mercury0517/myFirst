import UIKit

class Toast {
    internal static func show(_ text: String, _ parent: UIView) {
        let label = UILabel()
        let width = parent.frame.size.width
        let height = parent.frame.size.height / 15
        var bottomPadding = 50.0
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            if let window = windowScene?.windows.first {
                bottomPadding = window.safeAreaInsets.bottom
            }
        }
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.textColor = UIColor.white
        label.textAlignment = .center;
        label.text = text
         
        label.frame = CGRect(x: parent.frame.size.width / 2 - (width / 2), y: parent.frame.size.height - height - bottomPadding, width: width, height: height)
        parent.addSubview(label)
         
        UIView.animate(withDuration: 1.0, delay: 3.0, options: .curveEaseOut, animations: {
            label.alpha = 0.0
        }, completion: { _ in
            label.removeFromSuperview()
        })
    }
}
