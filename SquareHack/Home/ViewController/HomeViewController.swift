import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    var catalogAPICoordinator: CatalogAPICoordinatorProtocol?
    var customersAPICoordinator: CustomersAPICoordinatorProtocol?
    
    var rewards: [Reward] = [
        Reward(image: "Coffee", logo: "PretLogo", title: "Pret A Manger", purchasesToGo: 0),
        Reward(image: "DominosBackground", logo: "dominos", title: "Domino's", purchasesToGo: 1),
        Reward(image: "Pharmacy", logo: "Boots", title: "Boots", purchasesToGo: 2),
        Reward(image: "Bagondus", logo: "makdonaldeu", title: "McDonald's", purchasesToGo: 4),
    ]
    
    var favourites: [Favourite] = [
        Favourite(image: "OlleBackground", logo: "Olle", title: "Olle", type: "Korean Restaurant focused on Authentic BBQ", latitude: 51.512044, longitude: -0.131494, hasOffer: true),
        Favourite(image: "EATBackground", logo: "EAT", title: "Eat Tokyo", type: "Japanese Izayaka-Style Restaurant ", latitude: 51.512584, longitude: -0.120504, hasOffer: false),
        Favourite(image: "GRMImage", logo: "GRM", title: "Gordon Ramsay's Street Burger - The O2", type: "Burger Joint like no other", latitude: 51.502724, longitude: 0.0045118, hasOffer: true),
        Favourite(image: "DIYABackground", logo: "DIYA", title: "DIYA - Indian Cuisine", type: "Indian Restaurant bringing the Occident", latitude: 37.78352, longitude: -122.40938, hasOffer: false),
        Favourite(image: "Bagondus", logo: "makdonaldeu", title: "McDonald's", type: "Fast-food staple, loved by all", latitude: 37.76538, longitude: -122.407954, hasOffer: false),
        Favourite(image: "Coffee", logo: "PretLogo", title: "Pret A Manger", type: "Coffee shop, sandwich bar, all in one", latitude: 37.76538, longitude: -122.407954, hasOffer: true),
    ]
    
    var shuffledFavourites: [Favourite] = []
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        topBarView.delegate = self
        return topBarView
    }()
    
    lazy var countView = CountView()
    
    lazy var giftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "81 Points to\nnext Tier"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy var rewardLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "My Rewards"
        return label
    }()
    
    lazy var rewardMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var rewardCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(RewardCell.self, forCellWithReuseIdentifier: "rewardCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    lazy var favouriteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Favourites"
        return label
    }()
    
    lazy var favouriteMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var favouriteCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(FavouriteCell.self, forCellWithReuseIdentifier: "favouriteCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    init(viewModel: HomeViewModelProtocol,
         catalogAPICoordinator: CatalogAPICoordinatorProtocol,
         customersAPICoordinator: CustomersAPICoordinatorProtocol) {
        self.viewModel = viewModel
        self.catalogAPICoordinator = catalogAPICoordinator
        self.customersAPICoordinator = customersAPICoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        checkLoggedIn()
        shuffledFavourites = favourites.shuffled()
//        let uuid = UUID()
//        let uuidString = uuid.uuidString
//        let object = CatalogObjectModel(idempotencyKey: uuidString, object: Object(type: "ITEM", itemData: ItemData(abbreviation: "Coke", name: "Coke", variations: [Variation(id: "#Zero", type: "ITEM_VARIATION", itemVariationData: ItemVariationData(name: "Zero", pricingType: "FIXED_PRICING", priceMoney: PriceMoney(amount: 1000, currency: "GBP")))]), id: "#Coke"))
//
//        catalogAPICoordinator?.createItem(body: object, logLevel: .debug, completion: { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        })
        
//        let object2 = CatalogQueryModel(exactQuery: ExactQuery(attributeName: "name", attributeValue: "Coffee"))
//
//        catalogAPICoordinator?.listCatalogItems(type: .item, logLevel: .minimal, completion: { result in
//            switch result {
//            case .success(let success):
//                print(success)
//                break
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        })
//        let customer = CustomerModel(givenName: "Artemiy", familyName: "Malyshau", emailAddress: "amalyshau2002@gmail.com")
//        customersAPICoordinator?.createCustomer(customerInfo: customer, completion: { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        })
    }
    
    func setUpView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(topBarView)
        view.addSubview(countView)
        view.addSubview(giftLabel)
        view.addSubview(rewardLabel)
        view.addSubview(rewardMoreButton)
        view.addSubview(rewardCollectionView)
        view.addSubview(favouriteLabel)
        view.addSubview(favouriteMoreButton)
        view.addSubview(favouriteCollectionView)

        topBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 32)

        countView.anchor(top: topBarView.bottomAnchor, paddingTop: 44, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 64)
        
        giftLabel.anchor(top: topBarView.bottomAnchor, paddingTop: 74, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 40, width: 0, height: 0)
        
        rewardLabel.anchor(top: countView.bottomAnchor, paddingTop: 108, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        rewardMoreButton.anchor(top: countView.bottomAnchor, paddingTop: 104, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        rewardCollectionView.anchor(top: rewardLabel.bottomAnchor, paddingTop: -4, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 170)
        
        favouriteLabel.anchor(top: rewardCollectionView.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        favouriteMoreButton.anchor(top: rewardCollectionView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        favouriteCollectionView.anchor(top: favouriteLabel.bottomAnchor, paddingTop: -2, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 180)
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
            setupUI()
        }
    }
    
    func setupUI() {
        
        viewModel?.getUserPointsBalance(completion: { [weak self] points in
            self?.countView.updatePointsAndTier(points: points)
        })
    }
}


extension HomeViewController: TopBarViewDelegate {
    
    func actionHandle(sender: UIAction) {
        switch sender.title {
        case "Profile":
            let profileVC = ProfileViewController()
            present(profileVC, animated: true, completion: nil)
        case "Settings":
            let settingsVC = SettingsViewController()
            present(settingsVC, animated: true, completion: nil)
        case "Sign Out":
            logOut()
        default:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.rewardCollectionView {
            return rewards.count
        } else if collectionView == self.favouriteCollectionView {
            return shuffledFavourites.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.rewardCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "rewardCell",
                for: indexPath) as? RewardCell else { return UICollectionViewCell() }
            let reward = rewards[indexPath.row]
            cell.configure(data: reward)
            return cell
        } else if collectionView == self.favouriteCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "favouriteCell",
                for: indexPath) as? FavouriteCell else { return UICollectionViewCell() }
            let favourite = shuffledFavourites[indexPath.row]
            cell.configure(data: favourite)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == rewardCollectionView {
            let itemSize = CGSize(width: 130, height: 145)
            return itemSize
        } else {
            let itemSize = CGSize(width: 240, height: 160)
            return itemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // go to main view
//        let api = APICoordinator()
//        let empty = Car
//        let vc = ShopWalletViewController(viewModel: ShopWalletControllerViewModel(catalogAPICoordinator: CatalogAPICoordinator(apiCoordinator: api), customersAPICoordinator: CustomersAPICoordinator(apiCoordinator: api), subscriptionAPICoordinator: SubscriptionAPICoordinator(apiCoordinator: api)), model: //)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
