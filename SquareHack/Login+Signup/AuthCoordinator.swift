import Foundation
import Firebase

typealias CreateUserResult = (_ user: User?, _ error: SignUpError?) -> Void
typealias CreateUserDocumentResult = (_ error: Error?) -> Void

protocol AuthCoordinatorProtocol {
    func createUser(email: String, password: String, completion: @escaping CreateUserResult)
    func createUserDocument(uid: String, name: String, completion: @escaping CreateUserDocumentResult)
}

class AuthCoordinator: AuthCoordinatorProtocol {
    
    func createUser(email: String, password: String, completion: @escaping CreateUserResult) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                completion(user, nil)
            } else {
                completion(nil, self.handleError(error: error))
            }
        }
    }
    
    func createUserDocument(uid: String, name: String, completion: @escaping CreateUserDocumentResult) {
        let ref = Firestore.firestore().collection("users").document(uid)
        ref.setData(["name": name, "uid": uid], merge: true) { error in
                if error != nil { completion(error) }
                completion(nil)
        }
    }
}

//Private methods
extension AuthCoordinator {
    
    private func handleError(error: Error?) -> SignUpError {
        if let error = error as NSError? {
            switch error.code {
            case AuthErrorCode.operationNotAllowed.rawValue:
                return SignUpError.operationNotAllowed
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                return SignUpError.emailAlreadyInUse
            case AuthErrorCode.invalidEmail.rawValue:
                return SignUpError.invalidEmail
            case AuthErrorCode.weakPassword.rawValue:
                return SignUpError.weakPassword
            case AuthErrorCode.missingEmail.rawValue:
                return SignUpError.missingEmail
            case AuthErrorCode.networkError.rawValue:
                return SignUpError.networkError
            default:
                return SignUpError.unknown
            }
        }
        return SignUpError.unknown
    }
}
