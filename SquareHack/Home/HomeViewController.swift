import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var rewards: [Reward] = [
        Reward(image: "github", logo: "github", title: "Terry", type: "3 more purchases"),
        Reward(image: "github", logo: "github", title: "Nine", type: "2 more purchases"),
        Reward(image: "github", logo: "github", title: "Rocky", type: "4 more purchases"),
        Reward(image: "github", logo: "github", title: "KFC", type: "1 more purchases"),
    ]
    
    var favourites: [Favourite] = []
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        topBarView.signOutHandler = { [weak self] in
            self?.logOut()
        }
        return topBarView
    }()
    
    lazy var countView: CountView = {
        let countView = CountView()
        return countView
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
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .white
        
        if checkLoggedIn() {
            viewModel?.getUserPointsBalance(completion: { points in
                self.countView.updatePointsAndTier(points: points)
            })
        }

        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
                
        viewModel?.fetchFavourites { [weak self] error in
            if let error = error {
                print("Failed to fetch favourites: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.favouriteCollectionView.reloadData() 
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    func setUpView() {
        view.addSubview(topBarView)
        view.addSubview(countView)
        view.addSubview(rewardLabel)
        view.addSubview(rewardMoreButton)
        view.addSubview(rewardCollectionView)
        view.addSubview(favouriteLabel)
        view.addSubview(favouriteMoreButton)
        view.addSubview(favouriteCollectionView)

        topBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 33)

        countView.anchor(top: topBarView.bottomAnchor, paddingTop: 44, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 64)
        
        rewardLabel.anchor(top: countView.bottomAnchor, paddingTop: 88, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        rewardMoreButton.anchor(top: countView.bottomAnchor, paddingTop: 84, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        rewardCollectionView.anchor(top: rewardLabel.bottomAnchor, paddingTop: -4, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 170)
        
        favouriteLabel.anchor(top: rewardCollectionView.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        favouriteMoreButton.anchor(top: rewardCollectionView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        favouriteCollectionView.anchor(top: favouriteLabel.bottomAnchor, paddingTop: -2, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 180)
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

    func checkLoggedIn() -> Bool {
        if Auth.auth().currentUser?.uid == nil {
            logOut()
            return false
        } else {
            // load data
            return true
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rewardCollectionView {
            return rewards.count
        } else {
            return viewModel?.favourites.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rewardCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "rewardCell",
                for: indexPath) as? RewardCell else { return UICollectionViewCell() }
            let reward = rewards[indexPath.row]
            cell.configure(data: reward)
            cell.backgroundColor = .clear
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "favouriteCell",
                for: indexPath) as? FavouriteCell else { return UICollectionViewCell() }
            if let favourite = viewModel?.favourites[indexPath.row] {
                cell.titleLabel.text = favourite.title
                cell.typeLabel.text = favourite.type
                cell.configure(data: favourite)
            }
            cell.backgroundColor = .clear
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
        if collectionView == rewardCollectionView {
            return 10
        } else {
            return 10
        }
    }
}
