import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    
    var uid: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
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
        setupNavBar()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getUserPointsBalance(completion: { points in
            print(points) //<--- this variable points holds their points
        // eg you could do -> pointsLabel.text = "\(points)"
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.pointsListener?.remove()
    }
    
    
    func setupNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "x.square.fill")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(logOut))
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
