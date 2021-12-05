import UIKit

class CustomTextField: UITextField {
    var padding: CGPoint = CGPoint(x: 6.0, y: 0.0)
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   override func textRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
   }

   override func editingRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
   }

   override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
   }
}
