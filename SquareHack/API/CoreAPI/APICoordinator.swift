import Foundation

protocol APICoordinatorProtocol {
    func fetchAPI<T: Codable, U: Codable>(url: String, type: HTTPMethod, body: T, logLevel: APILogLevel, access: APIAccessType, completion: @escaping(Result<U, APIError>) -> Void)
    func handleAPIResponse<T: Codable>(_ result: Result<T, APIError>, completion: @escaping(Result<T, APIError>) -> Void)
}

class APICoordinator: APICoordinatorProtocol {
    
    struct Constants {
        static let sandboxAccessToken = "EAAAEPe7Gj3kGGHc4HYXSumr8UwoNOr33HguS2BT1ApYiQDNddcDAJlo7xiX_0Rt"
        static let prodAccessToken = "EAAAEUkMR6rZ208JGnNJyRzkdQk7OCdHSvqrUFC_bkSfq0ihpNy-AQ5TpeRR2q5b"
        static let sandboxBaseURL: String = "https://connect.squareupsandbox.com/v2/"
        static let prodBaseURL: String = "https://connect.squareup.com/v2/"
    }
    
    // MARK: PUBLIC
    func fetchAPI<T: Codable, U: Codable>(url: String, type: HTTPMethod, body: T, logLevel: APILogLevel, access: APIAccessType, completion: @escaping(Result<U, APIError>) -> Void) {
        let access = returnAccessType(access: access)
        let url = URL(string: access.url + url)
        createRequest(url: url, type: type, body: body, token: access.token) { [weak self] baseRequest in
            if let request = baseRequest {
                self?.fetchURLData(request: request, logLevel: logLevel) { [weak self] (result: Result<U, APIError>) in
                    self?.handleResult(result, completion: completion)
                }
            }
        }
    }
    
    func handleAPIResponse<T: Codable>(_ result: Result<T, APIError>, completion: @escaping(Result<T, APIError>) -> Void) {
        switch result {
        case .success(let model):
            completion(.success(model))
        case .failure(let error):
            print(error)
            completion(.failure(error))
        }
    }
    
    // MARK: PRIVATE
    
    private func returnAccessType(access: APIAccessType) -> APIAccessModel {
        switch access {
        case .sandbox:
            return APIAccessModel(url: Constants.sandboxBaseURL, token: Constants.sandboxAccessToken)
        case .production:
            return APIAccessModel(url: Constants.prodBaseURL, token: Constants.prodAccessToken)
        }
    }
    
    private func createRequest<T: Codable>(url: URL?, type: HTTPMethod, body: T?, token: String, completion: @escaping(URLRequest?) -> Void) {
        guard let apiURL = url else { completion(nil); return}
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        request.setValue("2023-05-17", forHTTPHeaderField: "Square-Version")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 15
        
        if type != .GET {
            if let body = body {
                do {
                    let encoder = JSONEncoder()
                    encoder.keyEncodingStrategy = .convertToSnakeCase
                    let jsonData = try encoder.encode(body)
                    request.httpBody = jsonData
                } catch {
                    completion(nil)
                    print("Error encoding JSON: \(error)")
                }
            }
        }
        completion(request)
    }
    
    private func fetchURLData<T: Codable>(request: URLRequest, logLevel: APILogLevel, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            self.handleLogLevel(logLevel: logLevel, data: data)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(APIError.jsonDecodingFailed(error)))
                }
            } else {
                completion(.failure(APIError.requestFailed(httpResponse.statusCode)))
            }
        }
        
        task.resume()
    }
    
    private func handleLogLevel(logLevel: APILogLevel, data: Data) {
        switch logLevel {
        case .debug:
            printData(data: data)
        case .minimal:
            break
        }
    }
    
    private func handleResult<T: Codable>(_ result: Result<T, APIError>, completion: @escaping(Result<T, APIError>) -> Void){
        switch result {
        case .success(let model):
            completion(.success(model))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func printData(data: Data) {
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
}
