import UIKit
import PureLayout

class MoreInformationViewController: UIViewController {
    let tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    private func configSubViews() {
        self.navigationItem.title = "その他"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(MoreTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func applyStyling() {
        self.tableView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.tableView.autoPinEdge(toSuperviewEdge: .top, withInset: -25.0)
        self.tableView.autoPinEdge(toSuperviewEdge: .left)
        self.tableView.autoPinEdge(toSuperviewEdge: .right)
        self.tableView.autoPinEdge(toSuperviewEdge: .bottom)
    }
}

extension MoreInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "利用規約"
        case 1:
            cell.textLabel?.text = "プライバシーポリシー"
        case 2:
            cell.textLabel?.text = "お問い合わせ"
        default:
            break
        }        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let view = TermOfUseViewController()
            self.navigationController?.pushViewController(view, animated: true)
        case 1:
            let view = PrivacyPolicyViewController()
            self.navigationController?.pushViewController(view, animated: true)
        case 2:
            let view = InquiryViewController()
            self.navigationController?.pushViewController(view, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}
