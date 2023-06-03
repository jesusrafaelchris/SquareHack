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
    // Creates a new order that can include information about products for purchase and settings to apply to the purchase.
    // https://developer.squareup.com/reference/square/orders-api/create-order
    // POST/v2/orders
    func createOrder() {
        
    }

    // Batch Retrieve Orders
    // Retrieves a set of orders by their IDs.
    // https://developer.squareup.com/reference/square/orders-api/batch-retrieve-orders
    // POST/v2/orders/batch-retrieve

    // Calculate Order
    // Enables applications to preview order pricing without creating an order.
    // https://developer.squareup.com/reference/square/orders-api/calculate-order
    // POST/v2/orders/calculate

    // Beta - Search Orders
    // Search all orders for one or more locations.
    // https://developer.squareup.com/reference/square/orders-api/search-orders
    // POST/v2/orders/search

    // Retrieve Order
    // Retrieves an Order by ID.
    // https://developer.squareup.com/reference/square/orders-api/retrieve-order
    // GET/v2/orders/{order_id}
    func retrieveOrder(orderID: String) {
        
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
