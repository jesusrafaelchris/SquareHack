import Foundation

protocol APICoordinatorProtocol {
    func createRequest<T: Codable>(url: URL?, type: HTTPMethod, body: T?,completion: @escaping(URLRequest?) -> Void)
    var sandboxBaseURL: String { get }
    var prodBaseURL: String { get }
    func printData(data: Data)
}

class APICoordinator: APICoordinatorProtocol {
    
    var sandboxBaseURL: String = "https://connect.squareupsandbox.com/v2/"
    var prodBaseURL: String = "https://connect.squareup.com/v2/"
    
    struct Constants {
        static var sandboxAccessToken = "EAAAEPe7Gj3kGGHc4HYXSumr8UwoNOr33HguS2BT1ApYiQDNddcDAJlo7xiX_0Rt"
        static var prodAccessToken = "EAAAEUkMR6rZ208JGnNJyRzkdQk7OCdHSvqrUFC_bkSfq0ihpNy-AQ5TpeRR2q5b"
    }
    
    func createRequest<T: Codable>(url: URL?, type: HTTPMethod, body: T?, completion: @escaping(URLRequest?) -> Void) {
        guard let apiURL = url else { completion(nil); return}
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        request.setValue("2023-05-17", forHTTPHeaderField: "Square-Version")
        request.setValue("Bearer \(Constants.prodAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 15
        if let body = body {
            do {
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                encoder.outputFormatting = .prettyPrinted
                let jsonData = try encoder.encode(body)
                request.httpBody = jsonData
                //print(String(data: jsonData, encoding: .utf8) ?? "")
            } catch {
                completion(nil)
                print("Error encoding JSON: \(error)")
            }
        }
        completion(request)
    }
    
    func printData(data: Data) {
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
}
