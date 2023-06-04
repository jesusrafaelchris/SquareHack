import Foundation

protocol CatalogAPICoordinatorProtocol {
    func createItem(body: CatalogObjectModel, logLevel: APILogLevel, completion: @escaping(Result<CatalogResponseModel,APIError>) -> Void)
    func searchCatalogItems(body: CatalogQueryModel, logLevel: APILogLevel, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void)
    func listCatalogItems(type: CatalogObjectType?, logLevel: APILogLevel, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void)
    func createSubscription(body: SubscriptionPlanModel, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void)
}

class CatalogAPICoordinator: CatalogAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
        static let upsertCatalog = "catalog/object"
        static let searchCatalog = "catalog/search"
        static let listCatalog = "catalog/list"
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }
    
    // Upsert Catalog Object
    // https://developer.squareup.com/explorer/square/catalog-api/upsert-catalog-object
    func createItem(body: CatalogObjectModel, logLevel: APILogLevel, completion: @escaping(Result<CatalogResponseModel,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.upsertCatalog, type: .POST, body: body, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }
    
    func createSubscription(body: SubscriptionPlanModel, logLevel: APILogLevel, completion: @escaping(Result<SubscriptionPlanResponse,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.upsertCatalog, type: .POST, body: body, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }
    
    // Search Catalog Items
    // https://developer.squareup.com/explorer/square/catalog-api/search-catalog-objects
    func searchCatalogItems(body: CatalogQueryModel, logLevel: APILogLevel, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            apiCoordinator.fetchAPI(url: Constants.searchCatalog, type: .POST, body: body, logLevel: logLevel, access: .production) { response in
                apiCoordinator.handleAPIResponse(response, completion: completion)
            }
        }
    }
    
    // List Catalog Items
    // https://developer.squareup.com/explorer/square/catalog-api/list-catalog
    func listCatalogItems(type: CatalogObjectType?, logLevel: APILogLevel, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            if let objectType = type {
                apiCoordinator.fetchAPI(url: Constants.listCatalog + "?types=\(objectType.rawValue)", type: .GET, body: nil as CatalogQueryModel?, logLevel: logLevel, access: .production) { response in
                    apiCoordinator.handleAPIResponse(response, completion: completion)
                }
            } else {
                completion(.failure(APIError.invalidObjectType))
            }
        }
    }
}
