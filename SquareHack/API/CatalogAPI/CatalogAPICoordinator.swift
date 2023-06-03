import Foundation

protocol CatalogAPICoordinatorProtocol {
    func createItem(body: CatalogObjectModel, completion: @escaping(Result<Bool,APIError>) -> Void)
    func searchCatalogItems(body: CatalogQueryModel, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void)
    func listCatalogItems(type: CatalogObjectType?, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void)
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
    func createItem(body: CatalogObjectModel, completion: @escaping(Result<Bool,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            let url = URL(string: apiCoordinator.prodBaseURL + Constants.upsertCatalog)
            apiCoordinator.createRequest(url: url, type: .POST, body: body) { baseRequest in
                if let baseRequest = baseRequest {
                    let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
                        apiCoordinator.printData(data: data)
                        guard let httpResponse = response as? HTTPURLResponse else {
                            completion(.failure(APIError.invalidResponse))
                            return
                        }
                        
                        if (200...299).contains(httpResponse.statusCode) {
                            completion(.success(true))
                        } else {
                            completion(.failure(APIError.requestFailed(httpResponse.statusCode)))
                        }
                    }
                    task.resume()
                } else {
                    completion(.failure(APIError.invalidURL))
                }
            }
        }
    }
    
    // Search Catalog Items
    // https://developer.squareup.com/explorer/square/catalog-api/search-catalog-objects
    func searchCatalogItems(body: CatalogQueryModel, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            let url = URL(string: apiCoordinator.prodBaseURL + Constants.searchCatalog)
            apiCoordinator.createRequest(url: url, type: .POST, body: body) { baseRequest in
                if let baseRequest = baseRequest {
                    let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }

                        guard let httpResponse = response as? HTTPURLResponse else {
                            completion(.failure(APIError.invalidResponse))
                            return
                        }
                        
                        if (200...299).contains(httpResponse.statusCode) {
                            do {
                                 let result = try JSONDecoder().decode(CatalogSearchModel.self, from: data)
                                 completion(.success(result))
                             } catch {
                                 completion(.failure(APIError.jsonDecodingFailed(error)))
                             }
                        } else {
                            completion(.failure(APIError.requestFailed(httpResponse.statusCode)))
                        }
                    }
                    task.resume()
                } else {
                    completion(.failure(APIError.invalidURL))
                }
            }
        }
    }
    
    // List Catalog Items
    // https://developer.squareup.com/explorer/square/catalog-api/list-catalog
    func listCatalogItems(type: CatalogObjectType?, completion: @escaping(Result<CatalogSearchModel,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            if let objectType = type {
                let url = URL(string: apiCoordinator.prodBaseURL + Constants.listCatalog + "?types=\(objectType.rawValue)")
                apiCoordinator.createRequest(url: url, type: .GET, body: nil as CatalogQueryModel?) { baseRequest in
                    if let baseRequest = baseRequest {
                        let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
                            guard let data = data, error == nil else {
                                completion(.failure(APIError.failedToGetData))
                                return
                            }

                            guard let httpResponse = response as? HTTPURLResponse else {
                                completion(.failure(APIError.invalidResponse))
                                return
                            }
                            
                            if (200...299).contains(httpResponse.statusCode) {
                                do {
                                     let result = try JSONDecoder().decode(CatalogSearchModel.self, from: data)
                                     completion(.success(result))
                                 } catch {
                                     completion(.failure(APIError.jsonDecodingFailed(error)))
                                 }
                            } else {
                                completion(.failure(APIError.requestFailed(httpResponse.statusCode)))
                            }
                        }
                        task.resume()
                    } else {
                        completion(.failure(APIError.invalidURL))
                    }
                }
            } else {
                completion(.failure(APIError.invalidObjectType))
            }
        }
    }
}
