import UIKit

class WalletViewController: UIViewController {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    lazy var cardCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewLayout = HFCardCollectionViewLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.isScrollEnabled = true
        collectionview.bounces = true
        collectionview.bouncesZoom = true
        collectionview.alwaysBounceVertical = true
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpCardLayout()
    }
    
    func setUpCardLayout() {
        if let cardCollectionViewLayout = self.cardCollectionView.collectionViewLayout as? HFCardCollectionViewLayout {
            self.cardCollectionViewLayout = cardCollectionViewLayout
        }
        self.cardCollectionViewLayout?.firstMovableIndex = 0
        self.cardCollectionViewLayout?.cardHeadHeight = 80
        self.cardCollectionViewLayout?.cardShouldExpandHeadHeight = false
        self.cardCollectionViewLayout?.cardShouldStretchAtScrollTop = true
        self.cardCollectionViewLayout?.cardMaximumHeight = 250
        self.cardCollectionViewLayout?.bottomNumberOfStackedCards = 5
        self.cardCollectionViewLayout?.bottomStackedCardsShouldScale = false
        self.cardCollectionViewLayout?.bottomCardLookoutMargin = 100
        self.cardCollectionViewLayout?.spaceAtTopForBackgroundView = 0
        self.cardCollectionViewLayout?.spaceAtTopShouldSnap = true
        self.cardCollectionViewLayout?.spaceAtBottom = 0
        self.cardCollectionViewLayout?.scrollAreaTop = 120
        self.cardCollectionViewLayout?.scrollAreaBottom = 120
        self.cardCollectionViewLayout?.scrollShouldSnapCardHead = false
        self.cardCollectionViewLayout?.scrollStopCardsAtTop = true
        self.cardCollectionViewLayout?.bottomStackedCardsMinimumScale = 0.94
        self.cardCollectionViewLayout?.bottomStackedCardsMaximumScale = 1.0
    }
  
    func setUpView() {
        view.backgroundColor = .white
        self.title = "Wallet"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(cardCollectionView)
        
        cardCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0,
                                  left: view.leftAnchor, paddingLeft: 16,
                                  right: view.rightAnchor, paddingRight: 16,
                                  width: 0, height: 0)
    }
}

extension WalletViewController: UICollectionViewDelegate,UICollectionViewDataSource, HFCardCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cardCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        switch indexPath.row {
        case 0 :
            cell.backgroundColor = UIColor.fromHex(hexString: "E6E5D9")
            break
        case 1 :
            cell.backgroundColor = UIColor.fromHex(hexString: "ECEBA2")
            break
        case 2 :
            cell.backgroundColor = UIColor.fromHex(hexString: "9FCABA")
            break
        case 3 :
            cell.backgroundColor = UIColor.fromHex(hexString: "DFDFF8")
            break
        default:
            cell.backgroundColor = UIColor.fromHex(hexString: "E6E5D9")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.cardCollectionViewLayout?.revealedIndex == indexPath.item {
            self.cardCollectionViewLayout?.unrevealRevealedCardAction()
            // go to main view
            let api = APICoordinator()
            let vc = ShopWalletViewController(viewModel: ShopWalletControllerViewModel(catalogAPICoordinator: CatalogAPICoordinator(apiCoordinator: api), customersAPICoordinator: CustomersAPICoordinator(apiCoordinator: api), subscriptionAPICoordinator: SubscriptionAPICoordinator(apiCoordinator: api)))
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.cardCollectionViewLayout?.revealCardAt(index: indexPath.item)
        }
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willRevealCardAtIndex index: Int) {
        if let cell = self.cardCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CardCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
        }
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willUnrevealCardAtIndex index: Int) {
        if let cell = self.cardCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CardCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
        }
    }
}
