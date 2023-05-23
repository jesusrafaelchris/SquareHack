import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        return topBarView
    }()
    
    lazy var countView: CountView = {
        let countView = CountView()
        return countView
    }()
    
    var viewModel: HomeViewModelProtocol?
    
    var uid: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    lazy var logOutButton: UIButton = {
        let logOutButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "x.circle.fill", withConfiguration: largeConfig)?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        logOutButton.setImage(largeBoldDoc, for: .normal)
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false

        return logOutButton
    }()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoggedIn()
        setUpView()
        view.backgroundColor = .white
        
        viewModel?.getUserPointsBalance(completion: { points in
            self.countView.updatePointsAndTier(points: points)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    func setUpView() {
        view.addSubview(topBarView)
        view.addSubview(countView)
        view.addSubview(logOutButton)

        
        topBarView.anchor(top: view.topAnchor, paddingTop: 70, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 24, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)

        countView.anchor(top: topBarView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        logOutButton.anchor(top: topBarView.topAnchor, paddingTop: 300, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 35, height: 35)
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.pointsListener?.remove()
    }
    
    
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError {
            print("logout error", logoutError)
        }
        
        let startview = ChooseSorLViewController()
        let nav = UINavigationController(rootViewController: startview)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }

    func checkLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            logOut()
        } else {
            // load data
        }
    }
}
