import Foundation

enum APIError: Error {
    case failedToGetData
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
    case jsonDecodingFailed(Error)
    case invalidObjectType

    var localizedDescription: String {
        switch self {
        case .failedToGetData:
            return "Failed to get data from the API."
        case .invalidURL:
            return "Invalid URL provided for the API request."
        case .invalidResponse:
            return "Invalid response received from the API."
        case .requestFailed(let statusCode):
            return "API request failed with status code: \(statusCode)"
        case .jsonDecodingFailed(let error):
            return "Failed to decode JSON: \(error)"
        case .invalidObjectType:
            return "Invalid Object type"
        }
    }
}
