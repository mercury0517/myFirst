import UIKit
import PureLayout

class HomeViewController: UIViewController {
    let scrollView = UIScrollView()
    
    let logoIcon = UIImageView(image: UIImage(named: "bump_logo"))
    let textLabel = UILabel()
    let noticeIcon = UIImageView(image: UIImage(named: "notice_icon"))
    let topBannerImage = UIImageView(image: UIImage(named: "top_aurora"))
    
    let newDiscView = DiscGroupView(discType: .new)
    
    let newsTitleLabel = UILabel()
    let newsStackView = UIStackView()
    
    let snsTitleLabel = UILabel()
    
    let snsContainer = UIView()
    let twitterTapArea = UIControl()
    let twitterIcon = UIImageView(image: UIImage(named: "twitter"))
    let lineTapArea = UIControl()
    let lineIcon = UIImageView(image: UIImage(named: "line"))
    let instagramTapArea = UIControl()
    let instagramIcon = UIImageView(image: UIImage(named: "instagram"))
    let youtubeTapArea = UIControl()
    let youtubeIcon = UIImageView(image: UIImage(named: "youtube"))
    
    let copyRightContainer = UIView()
    let copyRightIcon = UIImageView(image: UIImage(named: "bump_logo2"))
    let copyRightTitle = UILabel()
    let copyRightSubTitle = UILabel()
    
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
        
        self.configNewsStackView()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logoIcon)
        self.scrollView.addSubview(self.textLabel)
        self.scrollView.addSubview(self.noticeIcon)
        self.scrollView.addSubview(self.topBannerImage)
        self.scrollView.addSubview(self.newDiscView)
        self.scrollView.addSubview(self.newsTitleLabel)
        self.scrollView.addSubview(self.newsStackView)
        self.scrollView.addSubview(self.snsTitleLabel)
        self.scrollView.addSubview(self.snsContainer)
        self.snsContainer.addSubview(self.twitterTapArea)
        self.twitterTapArea.addSubview(self.twitterIcon)
        self.snsContainer.addSubview(self.lineTapArea)
        self.lineTapArea.addSubview(self.lineIcon)
        self.snsContainer.addSubview(self.instagramTapArea)
        self.instagramTapArea.addSubview(self.instagramIcon)
        self.snsContainer.addSubview(self.youtubeTapArea)
        self.youtubeTapArea.addSubview(self.youtubeIcon)
        self.scrollView.addSubview(self.copyRightContainer)
        self.copyRightContainer.addSubview(self.copyRightIcon)
        self.copyRightContainer.addSubview(self.copyRightTitle)
        self.copyRightContainer.addSubview(self.copyRightSubTitle)
    }
    
    private func configSubViews() {
        self.textLabel.text = "BUMP OF CHICKEN"
        
        // TODO: ????????????????????????????????????WKWebView??????????????????????????????????????????
        
        self.newsTitleLabel.text = "NEWS"
    
        self.newsStackView.alignment = .center
        self.newsStackView.axis = .vertical
        self.newsStackView.spacing = 20.0
        
        self.snsTitleLabel.text = "SNS??????????????????????????????!"
        
        self.snsContainer.isUserInteractionEnabled = true
        
        self.twitterTapArea.addTarget(self, action: #selector(self.tappedTwitter), for: .touchUpInside)
        self.lineTapArea.addTarget(self, action: #selector(self.tappedLine), for: .touchUpInside)
        self.instagramTapArea.addTarget(self, action: #selector(self.tappedInstagram), for: .touchUpInside)
        self.youtubeTapArea.addTarget(self, action: #selector(self.tappedYoutube), for: .touchUpInside)
        
        self.copyRightTitle.text = "SINCE 1996"
        self.copyRightSubTitle.text = "?? bumpofchicken.com. All rights Reserved."
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.textLabel.textColor = .black
        self.textLabel.font = UIFont(name: "Oswald", size: 26.0)
        
        self.newsTitleLabel.textColor = .black
        self.newsTitleLabel.font = UIFont(name: "Oswald", size: 20.0)
        
        self.snsTitleLabel.textColor = .lightGray
        self.snsTitleLabel.font = .systemFont(ofSize: 12.0)
        
        self.copyRightTitle.textColor = .black
        self.copyRightTitle.font = UIFont(name: "Oswald", size: 12.0)
        
        self.copyRightSubTitle.textColor = .lightGray
        self.copyRightSubTitle.font = .systemFont(ofSize: 8.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.logoIcon.autoSetDimensions(to: CGSize(width: 60.0, height: 60.0))
        self.logoIcon.autoPinEdge(toSuperviewEdge: .top)
        self.logoIcon.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.textLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.logoIcon)
        self.textLabel.autoPinEdge(.left, to: .right, of: self.logoIcon)
        self.textLabel.autoPinEdge(toSuperviewEdge: .right)
        
        self.noticeIcon.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))
        self.noticeIcon.autoAlignAxis(.horizontal, toSameAxisOf: self.logoIcon)
        self.noticeIcon.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        
        self.topBannerImage.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        self.topBannerImage.autoSetDimension(.height, toSize: 200.0)
        self.topBannerImage.autoPinEdge(.top, to: .bottom, of: self.logoIcon, withOffset: 5.0)
        self.topBannerImage.autoPinEdge(toSuperviewEdge: .left)
        self.topBannerImage.autoPinEdge(toSuperviewEdge: .right)
        
        self.newDiscView.autoPinEdge(.top, to: .bottom, of: self.topBannerImage, withOffset: 5.0)
        self.newDiscView.autoPinEdge(toSuperviewEdge: .left)
        self.newDiscView.autoPinEdge(toSuperviewEdge: .right)
        
        self.newsTitleLabel.autoPinEdge(.top, to: .bottom, of: self.newDiscView, withOffset: 15.0)
        self.newsTitleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.newsTitleLabel.autoPinEdge(toSuperviewEdge: .right)
        
        self.newsStackView.autoPinEdge(.top, to: .bottom, of: self.newsTitleLabel, withOffset: 10.0)
        self.newsStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.newsStackView.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.snsTitleLabel.autoPinEdge(.top, to: .bottom, of: self.newsStackView, withOffset: 35.0)
        self.snsTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.snsContainer.autoPinEdge(.top, to: .bottom, of: self.snsTitleLabel, withOffset: 5.0)
        self.snsContainer.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.twitterTapArea.autoPinEdge(toSuperviewEdge: .top)
        self.twitterTapArea.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.twitterTapArea.autoPinEdge(toSuperviewEdge: .bottom)
        self.twitterTapArea.autoSetDimensions(to: CGSize(width: 25.0, height: 25.0))
        
        self.twitterIcon.autoPinEdgesToSuperviewEdges()
        
        self.lineTapArea.autoPinEdge(toSuperviewEdge: .top)
        self.lineTapArea.autoPinEdge(.left, to: .right, of: self.twitterTapArea, withOffset: 10.0)
        self.lineTapArea.autoPinEdge(toSuperviewEdge: .bottom)
        self.lineTapArea.autoSetDimensions(to: CGSize(width: 25.0, height: 25.0))
        
        self.lineIcon.autoPinEdgesToSuperviewEdges()
        
        self.instagramTapArea.autoPinEdge(toSuperviewEdge: .top)
        self.instagramTapArea.autoPinEdge(.left, to: .right, of: self.lineTapArea, withOffset: 10.0)
        self.instagramTapArea.autoPinEdge(toSuperviewEdge: .bottom)
        self.instagramTapArea.autoSetDimensions(to: CGSize(width: 25.0, height: 25.0))
        
        self.instagramIcon.autoPinEdgesToSuperviewEdges()
        
        self.youtubeTapArea.autoPinEdge(toSuperviewEdge: .top)
        self.youtubeTapArea.autoPinEdge(.left, to: .right, of: self.instagramTapArea, withOffset: 10.0)
        self.youtubeTapArea.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        self.youtubeTapArea.autoPinEdge(toSuperviewEdge: .bottom)
        self.youtubeTapArea.autoSetDimensions(to: CGSize(width: 25.0, height: 25.0))
        
        self.youtubeIcon.autoPinEdgesToSuperviewEdges()
        
        self.copyRightContainer.autoPinEdge(.top, to: .bottom, of: self.snsContainer, withOffset: 20.0)
        self.copyRightContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.copyRightContainer.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.copyRightContainer.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60.0)
        
        self.copyRightIcon.autoSetDimensions(to: CGSize(width: 70.0, height: 70.0))
        self.copyRightIcon.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        
        self.copyRightTitle.autoPinEdge(toSuperviewEdge: .top, withInset: 15.0)
        self.copyRightTitle.autoPinEdge(.left, to: .right, of: self.copyRightIcon, withOffset: 10.0)
        
        self.copyRightSubTitle.autoPinEdge(.top, to: .bottom, of: self.copyRightTitle, withOffset: 5.0)
        self.copyRightSubTitle.autoPinEdge(.left, to: .right, of: self.copyRightIcon, withOffset: 10.0)
    }
    
    private func configNewsStackView() {
        let news1 = NewsView(updateTime: "2021.06.06", title: "????????????????????????????????????Ba.??????????????????????????????????????????????????????????????????")
        let news2 = NewsView(updateTime: "2021.05.17", title: "?????????????????????????????????????????????MV??????")
        let news3 = NewsView(updateTime: "2021.03.01", title: "???????????????????????????NHK??????????????????????????????????????????????????????????????????")
        
        self.newsStackView.addArrangedSubview(news1)
        self.newsStackView.addArrangedSubview(news2)
        self.newsStackView.addArrangedSubview(news3)
    }
    
    @objc private func tappedTwitter() {
        if let url = URL(string: "twitter:") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func tappedLine() {
        if let url = URL(string: "line://") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func tappedInstagram() {
        if let url = URL(string: "instagram:") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func tappedYoutube() {
        if let url = URL(string: "fb394518010609809:") {
            UIApplication.shared.open(url)
        }
    }
}
