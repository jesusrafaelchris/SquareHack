import Foundation

protocol SubscriptionAPICoordinatorProtocol {
    
}

class SubscriptionAPICoordinator: SubscriptionAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
        
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }
    
    // Create subscription
    // Creates a subscription to a subscription plan by a customer.
    // POST/v2/subscriptions

    // Search subscriptions
    // Searches for subscriptions.
    // POST/v2/subscriptions/search
}
