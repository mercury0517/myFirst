import UIKit

class FirstRegisterViewController: UIViewController {
    let window: UIWindow?
    
    let userName: String = ""
    
    let scrollView = UIScrollView()
    
    let descriptionLabel = UILabel()
    let registerImage = UIImageView(image: UIImage(named: "first_register"))
    
    let userNameTitleLabel = UILabel()
    let userNameTextField = CustomTextField()
    
    let termOfUseLabel = UILabel()
    let termOfUseButton = UIButton()
    
    let registerButton = UIButton()
    
    init(window: UIWindow?) {
        self.window = window
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "初回ユーザー登録"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver() // Notificationを画面が消えるときに削除
    }
    
    // Notificationを設定
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Notificationを削除
    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.descriptionLabel)
        self.scrollView.addSubview(self.registerImage)
        self.scrollView.addSubview(self.userNameTitleLabel)
        self.scrollView.addSubview(self.userNameTextField)
        self.scrollView.addSubview(self.termOfUseLabel)
        self.scrollView.addSubview(self.termOfUseButton)
        self.scrollView.addSubview(self.registerButton)
    }
    
    private func configSubViews() {
        self.descriptionLabel.text = "サービスをご利用される前に、あなたの名前を登録してください"
        self.descriptionLabel.numberOfLines = 0
        
        self.userNameTitleLabel.text = "YOUR NAME"
        
        self.userNameTextField.placeholder = "input your name"
        self.userNameTextField.text = self.userName
        self.userNameTextField.delegate = self
        
        self.termOfUseLabel.text = "「REGISTER」ボタンを押下した場合は、下記の利用規約に同意したものとみなします。必ずご一読ください。"
        self.termOfUseLabel.numberOfLines = 0
        
        self.termOfUseButton.setTitle("利用規約", for: .normal)
        self.termOfUseButton.addTarget(self, action: #selector(self.tappedTermOfUseButton), for: .touchUpInside)
        
        self.registerButton.setTitle("REGISTER", for: .normal)
        self.registerButton.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = .white
        
        self.descriptionLabel.font = .boldSystemFont(ofSize: 15.0)
        self.descriptionLabel.textColor = .black
        
        self.userNameTitleLabel.font = UIFont(name: "Oswald", size: 15.0)
        self.userNameTitleLabel.textColor = .black
        
        self.userNameTextField.textColor = .black
        
        self.termOfUseLabel.font = .systemFont(ofSize: 12.0)
        self.termOfUseLabel.textColor = .black
        
        self.termOfUseButton.setTitleColor(CustomUIColor.turquoise, for: .normal)
        self.termOfUseButton.titleLabel?.font = .systemFont(ofSize: 15.0)
        
        self.registerButton.backgroundColor = CustomUIColor.turquoise
        self.registerButton.layer.cornerRadius = 5.0
        self.registerButton.titleLabel?.font = UIFont(name: "Oswald", size: 15.0)
    }
    
    private func addConstraints() {
        self.scrollView.autoPinEdgesToSuperviewEdges()
        
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.descriptionLabel.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 32.0)
        
        self.registerImage.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: -30.0)
        self.registerImage.autoAlignAxis(toSuperviewAxis: .vertical)
        self.registerImage.autoSetDimension(.width, toSize: 100.0)
        self.registerImage.contentMode = .scaleAspectFit
        
        self.userNameTitleLabel.autoPinEdge(.top, to: .bottom, of: self.registerImage, withOffset: -30.0)
        self.userNameTitleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        
        self.userNameTextField.autoPinEdge(.top, to: .bottom, of: self.userNameTitleLabel, withOffset: 10.0)
        self.userNameTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.userNameTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.userNameTextField.autoSetDimension(.height, toSize: 50.0)
        
        self.termOfUseLabel.autoPinEdge(.top, to: .bottom, of: self.userNameTextField, withOffset: 20.0)
        self.termOfUseLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.termOfUseLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        self.termOfUseButton.autoPinEdge(.top, to: .bottom, of: self.termOfUseLabel, withOffset: 5.0)
        self.termOfUseButton.autoPinEdge(toSuperviewEdge: .left)
        self.termOfUseButton.autoSetDimension(.width, toSize: 100.0)
        
        self.registerButton.autoPinEdge(.top, to: .bottom, of: self.termOfUseButton, withOffset: 30.0)
        self.registerButton.autoSetDimension(.height, toSize: 45.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        self.registerButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20.0)
    }
    
    @objc private func tappedTermOfUseButton() {
        let termOfUseView = CustomNavigationController(rootViewController: TermOfUseViewController())
        
        self.present(termOfUseView, animated: true)
    }
    
    @objc private func tappedRegisterButton() {
        if
            let newUserName = self.userNameTextField.text,
            !newUserName.isEmpty
        {
            //ユーザー情報をキャッシュに保存する
            let userInfo = UserInfo(name: newUserName, topBanner: UIImage(named: "sky"), icon: UIImage(named: "sky"), favoriteDescription: "")
            
            // ハプティックフィードバックを入れる
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            // フラグをtrueにして2回目以降は表示されない様にする
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.isAlredayLaunch)
            
            let archivedUserInfo = try! NSKeyedArchiver.archivedData(withRootObject: userInfo, requiringSecureCoding: false)
            UserDefaults.standard.set(archivedUserInfo, forKey: UserDefaultKeys.userInfo)
            
            // ホーム画面を開く
            self.dismiss(animated: true) {
                self.window?.rootViewController = MyTabBarController()
            }
        } else {
            Toast.show("名前を入れてください", self.view)
        }
    }
}

extension FirstRegisterViewController: UITextFieldDelegate {
    // キーボードが現れた時に、画面全体をずらす。
    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform

        })
    }

    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in

            self.view.transform = CGAffineTransform.identity
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
