import Foundation
import Firebase

typealias SignUpResult = (_ error: String?) -> Void

protocol SignUpViewModelProtocol {
    func signUp(email: String, password: String, name: String, completion: @escaping SignUpResult)
}

class SignUpViewModel: SignUpViewModelProtocol {
    
    var authCoordinator: AuthCoordinatorProtocol?
    
    init(authCoordinator: AuthCoordinatorProtocol) {
        self.authCoordinator = authCoordinator
    }
    
    func signUp(email: String, password: String, name: String, completion: @escaping SignUpResult) {
        authCoordinator?.createUser(email: email, password: password, completion: { user, error in
            // Check for error in signing up
            if error != nil {
                completion(error?.errorString)
                return
            }
            
            if let user = user {
                // Create user document
                self.authCoordinator?.createUserDocument(uid: user.uid, name: name) { error in
                    // Check for error when creating document
                    if error != nil {
                        completion(error?.localizedDescription)
                        return
                    }
                    completion(nil)
                }
            }
        })
    }
}
