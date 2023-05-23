//import UIKit
//
//class TestViewController: UIViewController {
//
//    var apiCoordinator: APICoordinatorProcotol?
//
//    init(apiCoordinator: APICoordinatorProcotol) {
//        self.apiCoordinator = apiCoordinator
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        apiCoordinator?.createSubscription(id: "jeevan")
//    }
//
//}
//
//protocol APICoordinatorProcotol {
//    func createSubscription(id: String)
//}
//
//class APICoordinator: APICoordinatorProcotol {
//
//    struct Constants {
//        static var baseURl = "https://connect.squareup.com/v2/"
//    }
//
//    func createSubscription(id: String) {
//        createrRequest(url: buildURL(host: Constants.baseURl, path: "/create-subscription", queryItems: []), type: .PUT) { request in
//            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.failedToGetData))
//                    return
//                }
//                do {
//                      print("JSON String: \(String(data: data, encoding: .utf8))")
//                      let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//                      print(json)
////                    let decoder = JSONDecoder()
////                    let result = try decoder.decode(GetLyricsModel.self, from: data)
////                    completion(.success(result))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func createrRequest(url: URL?, type: HTTPMethod, completion: @escaping(URLRequest) -> Void) {
//        guard let apiURL = url else {return}
//        var request = URLRequest(url: apiURL)
//        request.httpMethod = type.rawValue
//        request.timeoutInterval = 15
//        completion(request)
//    }
//
//    func buildURL(host: String, path: String, queryItems: [URLQueryItem] = []) -> URL? {
//        var urlComponents = URLComponents()
//        urlComponents.host = host
//        urlComponents.path = path
//        urlComponents.queryItems = queryItems
//        return urlComponents.url
//    }
//
//}
//
//
//enum HTTPMethod: String {
//    case GET
//    case PUT
//}
