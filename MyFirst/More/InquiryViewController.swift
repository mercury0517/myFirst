import UIKit
import MessageUI

class InquiryViewController: UIViewController, MFMailComposeViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.presentMailView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func presentMailView() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["digit6444@gmail.com"]) // 宛先アドレス
            mail.setSubject("お問い合わせ") // 件名
            mail.setMessageBody("", isHTML: false) // 本文
            
            self.present(mail, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }

        dismiss(animated: true, completion: nil)
    }
}
