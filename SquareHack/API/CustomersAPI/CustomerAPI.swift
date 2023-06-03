import UIKit

protocol CustomersAPICoordinatorProtocol {
    func createCustomer(customerInfo: CustomerModel, completion: @escaping(Result<CustomerReponseModel,APIError>) -> Void)
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
    func createCustomer(customerInfo: CustomerModel, completion: @escaping(Result<CustomerReponseModel,APIError>) -> Void) {
        if let apiCoordinator = apiCoordinator {
            let url = URL(string: apiCoordinator.prodBaseURL + Constants.createCustomer)
            apiCoordinator.createRequest(url: url, type: .POST, body: customerInfo) { baseRequest in
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
                            do {
                                 let result = try JSONDecoder().decode(CustomerReponseModel.self, from: data)
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
}
