import UIKit
import Firebase
import FirebaseFirestore

protocol ShopWalletControllerViewModelProcotol {
    func checkIfCustomerExists(completion: @escaping(Bool) -> Void)
    func createCustomer(completion: @escaping(String) -> Void)
    func createSubscriptionPlan(subscriptionName: String, cost: Int, completion: @escaping(ReturnSubscriptionData) -> Void)
    func assignUserToSubscription(planID: String, customerID: String, completion: @escaping(CreateSubscriptionResponseModel) -> Void)
    func getCustomerID(completion: @escaping(String) -> Void)
}

class ShopWalletControllerViewModel: ShopWalletControllerViewModelProcotol {
    
    var catalogAPICoordinator: CatalogAPICoordinatorProtocol?
    var customersAPICoordinator: CustomersAPICoordinatorProtocol?
    var subscriptionAPICoordinator: SubscriptionAPICoordinatorProtocol?
    
    init(catalogAPICoordinator: CatalogAPICoordinatorProtocol,
         customersAPICoordinator: CustomersAPICoordinatorProtocol,
         subscriptionAPICoordinator: SubscriptionAPICoordinatorProtocol) {
        self.catalogAPICoordinator = catalogAPICoordinator
        self.customersAPICoordinator = customersAPICoordinator
        self.subscriptionAPICoordinator = subscriptionAPICoordinator
    }
    
    struct Constants {
        static let locationID = "LJZQSQ589ZCBC"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: PUblIC
    
    func checkIfCustomerExists(completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument(completion: { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            if let data = snapshot?.data() {
                do {
                    let user = try JSONDecoder().decode(UserModel.self, fromJSONObject: data)
                    if user.customerID == nil {
                        completion(false)
                    }
                    else {
                        completion(true)
                    }
                }
                catch {
                    print(error)
                }
            }
        })
    }
    
    func createCustomer(completion: @escaping(String) -> Void) {
        if let user = getuserDetails() {
            let customer = CustomerModel(givenName: user.firstName, familyName: user.lastName, emailAddress: user.email)
            customersAPICoordinator?.createCustomer(customerInfo: customer, logLevel: .debug, completion: { result in
                switch result {
                case .success(let model):
                    let customerID = model.customer.id
                    self.uploadCustomerIDToFirebase(id: customerID)
                    completion(customerID)
                case .failure(let error):
                    print(error)
                case .none:
                    print("should never print lol")
                }
            })
        }
    }
    
    func createSubscriptionPlan(subscriptionName: String, cost: Int, completion: @escaping(ReturnSubscriptionData) -> Void) {
        let plan = SubscriptionPlanModel(idempotencyKey: returnIdempotencyKey(), object:
                                            PlanObject(type: CatalogObjectType.subscriptionPlan.rawValue, id: "#plan", subscriptionPlanData: SubscriptionPlanData2(name: subscriptionName, phases: [SubscriptionPlanPhase(cadence: PlanCadence.monthly.rawValue, periods: 1, recurringPriceMoney: SubscriptionPriceMoney(amount: cost, currency: "GBP"))])))

        catalogAPICoordinator?.createSubscription(body: plan, logLevel: .debug, completion: { result in
            switch result {
            case .success(let model):
                let planID = model.catalogObject.subscriptionPlanData.phases.first?.uid ?? ""
                let name = model.catalogObject.subscriptionPlanData.name
                let price = model.catalogObject.subscriptionPlanData.phases.first?.recurringPriceMoney.amount ?? 0
                let returnData = ReturnSubscriptionData(name: name, uid: planID, price: price)
                completion(returnData)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func assignUserToSubscription(planID: String, customerID: String, completion: @escaping(CreateSubscriptionResponseModel)-> Void) {
        let subplan = SubscriptionAssignModel(idempotencyKey: returnIdempotencyKey(), locationID: Constants.locationID, planID: planID, customerID: customerID)
        subscriptionAPICoordinator?.createSubscription(body: subplan, logLevel: .debug, completion: { result in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getCustomerID(completion: @escaping(String) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument(completion: { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            if let data = snapshot?.data() {
                do {
                    let user = try JSONDecoder().decode(UserModel.self, fromJSONObject: data)
                    completion(user.customerID ?? "")
                }
                catch {
                    print(error)
                }
            }
        })
    }
    
    //MARK: PRIVATE
    
    func getuserDetails() -> FirstAndLastName? {
        if let displayName = Auth.auth().currentUser?.displayName {
            let nameComponents = displayName.split(separator: " ")
            if let firstName = nameComponents.first, let lastName = nameComponents.last {
                if let userEmail = Auth.auth().currentUser?.email {
                    let user = FirstAndLastName(firstName: String(firstName), lastName: String(lastName), email: userEmail)
                    return user
                }
            }
        }
        return nil
    }
    
    func uploadCustomerIDToFirebase(id: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).setData(["customerID": id], merge: true)
    }
    
    func returnIdempotencyKey() -> String {
        let uuid = UUID()
        let idempotencyKey = uuid.uuidString
        return idempotencyKey
    }
}

struct FirstAndLastName {
    var firstName: String
    var lastName: String
    var email: String
}
