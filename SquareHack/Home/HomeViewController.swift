import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        return topBarView
    }()
    
    lazy var rewardLabel: UILabel = {
        let text = UILabel()
        text.textColor = .redColour
        text.font = UIFont.boldSystemFont(ofSize: 8)
        text.text = "REWARD POINTS"
        return text
    }()
    
    lazy var rewardPoints: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 40)
        return text
    }()
    
    lazy var availablePoints: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "diamond.fill", withConfiguration: largeConfig)?.withTintColor(UIColor.redColour ?? .red).withRenderingMode(.alwaysOriginal)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tierLabel: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.font = UIFont.boldSystemFont(ofSize: 16)
        return text
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
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let pointsAsString = numberFormatter.string(from: NSNumber(value: points)) ?? "0"
            
            self.rewardPoints.text = "\(pointsAsString)"
            if points < 1000 {
                self.tierLabel.text = "Bronze Tier"
            } else if points < 5000 {
                self.tierLabel.text = "Silver Tier"
            } else {
                self.tierLabel.text = "Gold Tier"
            }
            
        })
    }
    
    func setUpView() {
        view.addSubview(topBarView)
        view.addSubview(logOutButton)
        view.addSubview(rewardLabel)
        view.addSubview(rewardPoints)
        view.addSubview(availablePoints)
        view.addSubview(tierLabel)
        
        topBarView.anchor(top: view.topAnchor, paddingTop: 70, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 24, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        rewardLabel.anchor(top: topBarView.bottomAnchor, paddingTop: 32, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
        
        rewardPoints.anchor(top: rewardLabel.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
        
        availablePoints.anchor(top: rewardLabel.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: rewardPoints.rightAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 0, height: 0)
        availablePoints.centerYAnchor.constraint(equalTo: rewardPoints.centerYAnchor).isActive = true
        
        tierLabel.anchor(top: rewardPoints.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
        
        logOutButton.anchor(top: topBarView.topAnchor, paddingTop: 300, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 35, height: 35)
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
