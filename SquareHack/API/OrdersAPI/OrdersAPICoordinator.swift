import Foundation

protocol OrdersAPICoordinatorProtocol {
    func createOrder(body: SubscriptionPlanModel, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void)
    func calculateOrder(body: SubscriptionPlanModel, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void)
    func retrieveOrder(orderID: String, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void)
}

class OrdersAPICoordinator: OrdersAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
        static let createOrder = "orders"
        static let calculate = "calculate"
        static let retrieve = "retrieve"
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }
    
    // Create Order
    // Creates a new order that can include information about products for purchase and settings to apply to the purchase.
    // https://developer.squareup.com/reference/square/orders-api/create-order
    // POST/v2/orders
    func createOrder(body: SubscriptionPlanModel, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.createOrder, type: .POST, body: body, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }

    // Calculate Order
    // Enables applications to preview order pricing without creating an order.
    // https://developer.squareup.com/reference/square/orders-api/calculate-order
    // POST/v2/orders/calculate
    func calculateOrder(body: SubscriptionPlanModel, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.createOrder, type: .POST, body: body, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }

    // Retrieve Order - Retrieves an Order by ID.
    // https://developer.squareup.com/reference/square/orders-api/retrieve-order
    // GET/v2/orders/{order_id}
    func retrieveOrder(orderID: String, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.retrieve, type: .POST, body: nil as SubscriptionPlanResponse?, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }

    // Update Order
    // Updates an open order by adding, replacing, or deleting fields.
    // https://developer.squareup.com/reference/square/orders-api/update-order
    // PUT/v2/orders/{order_id}

    // Beta - Pay Order
    // Pay for an order using one or more approved payments or settle an order with a total of 0.
    // https://developer.squareup.com/reference/square/orders-api/pay-order
    // POST/v2/orders/{order_id}/pay

}
