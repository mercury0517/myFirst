import UIKit
import PureLayout

class DiscViewController: UIViewController{
    let titleLabel = UILabel()
    let discGroupStackView = UIStackView()
    
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
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.discGroupStackView)
    }
    
    private func configSubViews() {
        self.titleLabel.text = "DISCOGRAPHY"
        
        self.discGroupStackView.alignment = .center
        self.discGroupStackView.axis = .vertical
        self.discGroupStackView.spacing = 20.0
        
        let discGroupForAlbum = DiscGroupView(discType: .album)
        let discGroupForSingle = DiscGroupView(discType: .single)
        
        self.discGroupStackView.addArrangedSubview(discGroupForAlbum)
        discGroupForAlbum.autoPinEdge(toSuperviewEdge: .left)
        discGroupForAlbum.autoPinEdge(toSuperviewEdge: .right)
        
        self.discGroupStackView.addArrangedSubview(discGroupForSingle)
        discGroupForSingle.autoPinEdge(toSuperviewEdge: .left)
        discGroupForSingle.autoPinEdge(toSuperviewEdge: .right)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Oswald", size: 20.0)
    }
    
    private func addConstraints() {
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.discGroupStackView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 20.0)
        self.discGroupStackView.autoPinEdge(toSuperviewEdge: .left)
        self.discGroupStackView.autoPinEdge(toSuperviewEdge: .right)
    }
}

