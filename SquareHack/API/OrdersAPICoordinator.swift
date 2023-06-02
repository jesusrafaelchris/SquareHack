import Foundation

protocol OrdersAPICoordinatorProtocol {
    
}

class OrdersAPICoordinator: OrdersAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }
    
    // Create Order
    // https://developer.squareup.com/reference/square/orders-api/create-order
}
