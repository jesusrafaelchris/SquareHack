import UIKit

protocol CustomersAPICoordinatorProtocol {
    func createCustomer(customerInfo: CustomerModel, logLevel: APILogLevel,completion: @escaping (Result<CustomerReponseModel, APIError>?) -> Void)
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
    func createCustomer(customerInfo: CustomerModel, logLevel: APILogLevel,completion: @escaping (Result<CustomerReponseModel, APIError>?) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.createCustomer, type: .POST, body: customerInfo, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }
}
