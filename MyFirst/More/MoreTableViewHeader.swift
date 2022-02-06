import UIKit

class MoreTableViewHeader: UITableViewHeaderFooterView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.tintColor = .white
    }
}
