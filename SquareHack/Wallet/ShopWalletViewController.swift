import UIKit

class ShopWalletViewController: UIViewController {
    
    var viewModel: ShopWalletControllerViewModelProcotol?
    var shop: String = "Pret A Manger"
    var pretColour = UIColor(red: 0.57, green: 0.00, blue: 0.15, alpha: 1.00)
    
    lazy var ticketStubView = TicketStubView()
    
    init(viewModel: ShopWalletControllerViewModelProcotol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        //subscribeToShop(shopName: "McD", cost: 500)
    }
    
    func setupNavBar() {
        self.title = shop
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(backToPreviousView))
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill")?.withTintColor(pretColour).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(heartShop))
    }
    
    @objc func backToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func heartShop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(ticketStubView)
        
        ticketStubView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12,
                              bottom: nil, paddingBottom: 0,
                              left: view.leftAnchor, paddingLeft: 16,
                              right: view.rightAnchor, paddingRight: 16,
                              width: 0, height: 150)
        
    }
    //MARK: Subscription API
    func subscribeToShop(shopName: String, cost: Int) {
        // 1. Check if Customer created for user
        viewModel?.checkIfCustomerExists(completion: { [weak self] exists in
            if !exists {
                // if not then create one using Customer API
                self?.viewModel?.createCustomer(completion: { [weak self] customerID in
                    self?.subscriptionManagement(shopName: shopName, customerID: customerID, cost: cost)
                })
            }
            else {
                // Otherwise get customerID and assign their subscription
                self?.viewModel?.getCustomerID(completion: { customerID in
                    self?.subscriptionManagement(shopName: shopName, customerID: customerID, cost: cost)
                })
            }
        })
    }
    
    func subscriptionManagement(shopName: String, customerID: String, cost: Int) {
        // 2. Create a subscription plan using Catalog API
        viewModel?.createSubscriptionPlan(subscriptionName: shopName, cost: cost, completion: { [weak self] plan in
            let planID = plan.uid
            // 3. Assign customer to subscription plan using Subscription API
            self?.viewModel?.assignUserToSubscription(planID: planID, customerID: customerID, completion: { [weak self] subscription in
            // 4. Display that customer has subscribed
                print(subscription.status)
            })
        })
    }
}
