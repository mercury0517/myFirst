import UIKit

class CustomTextView: UITextView {
    init() {
        super.init(frame: .zero, textContainer: nil)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textColor = .black
        self.textContainerInset = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)
        
        self.customKeyboardToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customKeyboardToolBar(){
        let tools = UIToolbar()
        tools.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.closeButtonTapped))
        tools.items = [spacer, closeButton]
        self.inputAccessoryView = tools
    }

    @objc private func closeButtonTapped() {
        self.endEditing(true)
        self.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.resignFirstResponder()
            return false
        }
        return true
    }
}
