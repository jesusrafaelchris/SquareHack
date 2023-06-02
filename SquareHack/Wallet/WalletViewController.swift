import UIKit

class WalletViewController: UIViewController {
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .white
        
    }
    
  
    func setUpView() {

    }
}
