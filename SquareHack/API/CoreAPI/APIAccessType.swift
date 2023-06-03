import Foundation

enum APIAccessType {
    case sandbox
    case production
}

enum APILogLevel {
    case debug
    case minimal
}

struct APIAccessModel {
    var url: String
    var token: String
}
