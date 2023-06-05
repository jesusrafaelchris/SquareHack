import UIKit

class ShopWalletViewController: UIViewController {
    
    var viewModel: ShopWalletControllerViewModelProcotol?
    
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
        subscribeToShop(shopName: "McD", cost: 500)
    }
    
    func setupView() {
        
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
