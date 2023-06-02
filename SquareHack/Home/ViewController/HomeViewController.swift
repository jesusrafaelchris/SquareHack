import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    var catalogAPICoordinator: CatalogAPICoordinatorProtocol?
    
    var rewards: [Reward] = [
        Reward(image: "github", logo: "github", title: "Terry", type: "3 more purchases"),
        Reward(image: "github", logo: "github", title: "Nine", type: "2 more purchases"),
        Reward(image: "github", logo: "github", title: "Rocky", type: "4 more purchases"),
        Reward(image: "github", logo: "github", title: "KFC", type: "1 more purchases"),
    ]
    
    var favourites = [FavouriteModel]()
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        topBarView.delegate = self
        return topBarView
    }()
    
    lazy var countView = CountView()
    
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
         catalogAPICoordinator: CatalogAPICoordinatorProtocol) {
        self.viewModel = viewModel
        self.catalogAPICoordinator = catalogAPICoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        checkLoggedIn()
//        let uuid = UUID()
//        let uuidString = uuid.uuidString
//        let object = CatalogObjectModel(idempotencyKey: uuidString, object: ItemObject(type: "ITEM", itemData: ItemData(abbreviation: "Coffee", name: "Coffee", variations: [Variation(id: "#Cream", type: "ITEM_VARIATION", itemVariationData: ItemVariationData(name: "Cream", pricingType: "FIXED_PRICING", priceMoney: PriceMoney(amount: 5, currency: "GBP")))]), id: "#Coffee"))
        
        let object2 = CatalogQueryModel(exactQuery: ExactQuery(attributeName: "name", attributeValue: "Coffee"))
        
        catalogAPICoordinator?.listCatalogItems(type: .item, completion: { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func setUpView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(topBarView)
        view.addSubview(countView)
        view.addSubview(rewardLabel)
        view.addSubview(rewardMoreButton)
        view.addSubview(rewardCollectionView)
        view.addSubview(favouriteLabel)
        view.addSubview(favouriteMoreButton)
        view.addSubview(favouriteCollectionView)

        topBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 32)

        countView.anchor(top: topBarView.bottomAnchor, paddingTop: 44, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 64)
        
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
        viewModel?.fetchFavourites { [weak self] favourites in
            self?.favourites = favourites
            DispatchQueue.main.async {
                self?.favouriteCollectionView.reloadData()
            }
        }
        
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
        case "Manage Subscription":
            let subscriptionVC = SubscriptionViewController()
            present(subscriptionVC, animated: true, completion: nil)
        case "Settings":
            let settingsVC = SettingsViewController()
            present(settingsVC, animated: true, completion: nil)
        default:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rewardCollectionView {
            return rewards.count
        } else {
            return favourites.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rewardCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "rewardCell",
                for: indexPath) as? RewardCell else { return UICollectionViewCell() }
            let reward = rewards[indexPath.row]
            cell.configure(data: reward)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "favouriteCell",
                for: indexPath) as? FavouriteCell else { return UICollectionViewCell() }
            let favourite = favourites[indexPath.row]
            cell.configure(data: favourite)
            return cell
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
}
