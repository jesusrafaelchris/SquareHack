import Foundation

protocol SubscriptionAPICoordinatorProtocol {
    func createSubscription(body: SubscriptionAssignModel, logLevel: APILogLevel, completion: @escaping(Result<CreateSubscriptionResponseModel,APIError>) -> Void) 
}

class SubscriptionAPICoordinator: SubscriptionAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
        static let createSubscription = "subscriptions"
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }
    
    // Create subscription
    // Creates a subscription to a subscription plan by a customer.
    // POST/v2/subscriptions
    func createSubscription(body: SubscriptionAssignModel, logLevel: APILogLevel, completion: @escaping(Result<CreateSubscriptionResponseModel,APIError>) -> Void) {
        apiCoordinator?.fetchAPI(url: Constants.createSubscription, type: .POST, body: body, logLevel: logLevel, access: .production, completion: { [weak self] result in
            self?.apiCoordinator?.handleAPIResponse(result, completion: completion)
        })
    }

    // Search subscriptions
    // Searches for subscriptions.
    // POST/v2/subscriptions/search
}
