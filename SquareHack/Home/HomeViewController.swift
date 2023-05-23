import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var uid: String {
        return Auth.auth().currentUser?.uid ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoggedIn()
        setupNavBar()
        view.backgroundColor = .white
        //monkey
        //bananna
        
        
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
