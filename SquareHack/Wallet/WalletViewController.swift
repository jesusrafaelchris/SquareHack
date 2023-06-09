import UIKit
import Firebase

class WalletViewController: UIViewController {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    var displayName: String? = Auth.auth().currentUser?.displayName
    
    var cards: [CardModel] = []
    
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
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(cardCollectionView)
        
        cardCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0,
                                  left: view.leftAnchor, paddingLeft: 16,
                                  right: view.rightAnchor, paddingRight: 16,
                                  width: 0, height: 0)
        cards = [
            
            CardModel(backgroundColor: "#DB0009", cardLabel: "Membership Number: 23513463461", topLabel: displayName!, bottomRightLabel: "123", setImage: "mcdonalds_text", setSquareImage: "mcdonalds", shopName: "McDonalds"),
            
            CardModel(backgroundColor: "#ffcf01", cardLabel: "Membership Number: 10195723552", topLabel: displayName!, bottomRightLabel: "24", setImage: "music_text", setSquareImage: "music", shopName: "Melodica"),
            
            CardModel(backgroundColor: "#910027", cardLabel: "Membership Number: 5232 2352 2621 6336", topLabel: displayName!, bottomRightLabel: "0", setImage: "pret_text", setSquareImage: "pret", shopName: "Pret A Manger"),
            
            CardModel(backgroundColor: "#f82494", cardLabel: "Membership Number: SPDRG0X2134", topLabel: displayName!, bottomRightLabel: "47", setImage: "superdrug_text", setSquareImage: "superdrug", shopName: "Superdrug"),
            
            CardModel(backgroundColor: "#173302", cardLabel: "Membership Number: 9982357235", topLabel: displayName!, bottomRightLabel: "236", setImage: "barber_text", setSquareImage: "barber", shopName: "Most High Barbers"),
            
            CardModel(backgroundColor: "#086494", cardLabel: "Membership Number: SQWT029423", topLabel: displayName!, bottomRightLabel: "127", setImage: "dominos_text", setSquareImage: "dominos", shopName: "Dominos"),
        ]
    }
}

extension WalletViewController: UICollectionViewDelegate,UICollectionViewDataSource, HFCardCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cardCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        let card = cards[indexPath.item]
        cell.configure(model: card)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.cardCollectionViewLayout?.revealedIndex == indexPath.item {
            let card = cards[indexPath.item]
            self.cardCollectionViewLayout?.unrevealRevealedCardAction()
            // go to main view
            let api = APICoordinator()
            let vc = ShopWalletViewController(viewModel: ShopWalletControllerViewModel(catalogAPICoordinator: CatalogAPICoordinator(apiCoordinator: api), customersAPICoordinator: CustomersAPICoordinator(apiCoordinator: api), subscriptionAPICoordinator: SubscriptionAPICoordinator(apiCoordinator: api)), model: card)
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
