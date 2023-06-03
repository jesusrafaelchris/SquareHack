import UIKit

protocol CustomersAPICoordinatorProtocol {
    func createCustomer(customerInfo: CustomerModel, completion: @escaping (Result<CustomerReponseModel, APIError>?) -> Void)
}

class CustomersAPICoordinator: CustomersAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
        static var createCustomer = "customers"
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }

    // Create Customer
    //https://developer.squareup.com/reference/square/customers-api/create-customer
    func createCustomer(customerInfo: CustomerModel, completion: @escaping (Result<CustomerReponseModel, APIError>?) -> Void) {
//        if let apiCoordinator = apiCoordinator {
//            let url = URL(string: apiCoordinator.prodBaseURL + Constants.createCustomer)
//
//            apiCoordinator.fetchAPI(url: url, type: .POST, body: customerInfo) { (result: ResultWrapper<CustomerReponseModel>?) in
//                completion(result)
//            }
//        } else {
//            completion(nil)
//        }
    }
}
