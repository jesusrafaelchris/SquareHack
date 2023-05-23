import Foundation
import Firebase

enum SignUpError {
    case operationNotAllowed
    case emailAlreadyInUse
    case invalidEmail
    case weakPassword
    case missingEmail
    case networkError
    case unknown
    
    var errorString: String {
        switch self {
        case .operationNotAllowed:
            return "Our server isn't having the best time right now."
        case .emailAlreadyInUse:
            return "The email address is already in use by another account."
        case .invalidEmail:
            return "The email address is badly formatted."
        case .weakPassword:
            return "The password must be 6 characters long or more."
        case .missingEmail:
            return "You forgot to put your email in."
        case .networkError:
            return "Check your connection and try again."
        case .unknown:
            return "We're having some issues try again later."
        }
    }
}
