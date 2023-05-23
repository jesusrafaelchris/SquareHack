import UIKit

class ChooseSorLViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "SquareHack"
        return label
    }()
    
    lazy var loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .creamColour
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var dontHaveAccount: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign up")
        let boldRange = (attributedString.string as NSString?)?.range(of: "Sign up")
        
        if let boldRange = boldRange {
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: label.font.pointSize), range: boldRange)
        }
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        return label
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 28
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(loginButton)
        stackView.setCustomSpacing(12, after: loginButton)
        stackView.addArrangedSubview(dontHaveAccount)
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTargets()
    }
    
    func setupTargets() {
        backgroundImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToSignUp))
        tap.numberOfTapsRequired = 1
        dontHaveAccount.addGestureRecognizer(tap)
    }
    
    func setupView() {
        view.backgroundColor = .creamColour
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(mainStackView)
        
        backgroundImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0,
                               bottom: view.bottomAnchor, paddingBottom: 0,
                               left: view.leftAnchor, paddingLeft: 0,
                               right: view.rightAnchor, paddingRight: 0,
                               width: 0, height: 0)
        
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.89).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mainStackView.anchor(top: nil, paddingTop: 0,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 50,
                             left: view.leftAnchor, paddingLeft: 0,
                             right: view.rightAnchor, paddingRight: 0,
                             width: 0, height: 0)
    }
    
    @objc func goToSignUp() {
        let vc = SignupViewController(viewModel: SignUpViewModel(authCoordinator: AuthCoordinator()))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToLogin() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
