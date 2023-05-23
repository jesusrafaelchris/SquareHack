import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.3)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let home = HomeViewController(viewModel: HomeViewModel())
        let homeimage = UIImage(systemName: "house")
        let homeselected = UIImage(systemName: "house.fill")
        home.tabBarItem =  UITabBarItem(title: "Home", image: homeimage, selectedImage: homeselected)
        
        let wallet = WalletViewController()
        let walletImage = UIImage(systemName: "wallet.pass")
        let walletselected = UIImage(systemName: "wallet.pass.fill")
        wallet.tabBarItem = UITabBarItem(title: "Wallet", image: walletImage, selectedImage: walletselected)
        
        let scanToPay = OrderDetailsViewController()
        let scanToPayimage = UIImage(systemName: "qrcode")
        let scanToPayselected = UIImage(systemName: "qrcode")
        scanToPay.tabBarItem = UITabBarItem(title: "Pay", image: scanToPayimage, selectedImage: scanToPayselected)
        
        let tabbarList = [home, wallet, scanToPay]
        
        viewControllers = tabbarList.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
