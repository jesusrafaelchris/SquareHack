import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "Welcome Back!"
        return label
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 28
        stackView.setCustomSpacing(48, after: titleLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        view.addSubview(mainStackView)
        view.addSubview(submitButton)
        
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32,
                          bottom: nil, paddingBottom: 0,
                          left: view.leftAnchor, paddingLeft: 32,
                          right: view.rightAnchor, paddingRight: 32,
                          width: 0, height: 0)
        
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        submitButton.anchor(top: nil, paddingTop: 0,
                             bottom: view.keyboardLayoutGuide.topAnchor, paddingBottom: 10,
                             left: view.leftAnchor, paddingLeft: 32,
                             right: view.rightAnchor, paddingRight: 32,
                             width: 0, height: 40)
        
    }
    
    @objc func login() {
        self.showSpinner(onView: view)
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty
        else {
            showAlert(with: "Try again")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                self?.showAlert(with: error.localizedDescription)
                self?.removeSpinner()
                return
            }
            self?.removeSpinner()
            strongSelf.dismiss(animated: true)
        }
    }
    
    func showAlert(with errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            login()
        }
        return true
    }
}

