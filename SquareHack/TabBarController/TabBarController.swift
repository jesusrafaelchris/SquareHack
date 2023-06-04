import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.setValue(CustomTabBar(), forKey: "tabBar")
        tabBar.tintColor = .black
        tabBar.backgroundColor = .clear
        tabBar.unselectedItemTintColor = .black.withAlphaComponent(0.3)
        
        let shadowView = UIView(frame: tabBar.frame)
        shadowView.backgroundColor = .white
        view.insertSubview(shadowView, belowSubview: tabBar)
        
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -4)
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.05
        shadowView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: tabBar.bounds.height)).cgPath

        let blurredView = UIView(frame: tabBar.frame)
        blurredView.backgroundColor = .white
        view.insertSubview(blurredView, belowSubview: tabBar)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurredView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredView.addSubview(blurEffectView)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let home = HomeViewController(viewModel: HomeViewModel(), catalogAPICoordinator:CatalogAPICoordinator(apiCoordinator: APICoordinator()), customersAPICoordinator: CustomersAPICoordinator(apiCoordinator: APICoordinator()))
        let homeimage = UIImage(systemName: "safari")
        let homeselected = UIImage(systemName: "safari.fill")
        home.tabBarItem =  UITabBarItem(title: "Discover", image: homeimage, selectedImage: homeselected)
        
        let discover = DiscoverViewController(viewModel: DiscoverViewModel())
        let discoverimage = UIImage(systemName: "bag")
        let discoverselected = UIImage(systemName: "bag.fill")
        discover.tabBarItem =  UITabBarItem(title: "Browse", image: discoverimage, selectedImage: discoverselected)
        
        let wallet = WalletViewController()
        let walletImage = UIImage(systemName: "wallet.pass")
        let walletselected = UIImage(systemName: "wallet.pass.fill")
        wallet.tabBarItem = UITabBarItem(title: "Wallet", image: walletImage, selectedImage: walletselected)
        
        let pay = PayViewController()
        let payimage = UIImage(systemName: "qrcode")
        let payselected = UIImage(systemName: "qrcode")
        pay.tabBarItem = UITabBarItem(title: "Pay", image: payimage, selectedImage: payselected)
        
        let tabbarList = [home, discover, wallet, pay]
        
        viewControllers = tabbarList.map {
            UINavigationController(rootViewController: $0)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 85
        return sizeThatFits
    }
}
