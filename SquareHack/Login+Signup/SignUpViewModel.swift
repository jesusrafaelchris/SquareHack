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
                self.changeDisplayName(forUID: user.uid, to: name)
                self.authCoordinator?.createUserDocument(uid: user.uid, name: name) { error in
                    // Check for error when creating document
                    if error != nil {
                        completion(error?.localizedDescription)
                        return
                    }
                    completion(nil)
                    // Comment
                }
            }
        })
    }

    func changeDisplayName(forUID uid: String, to displayName: String) {
        let userRef = Auth.auth().currentUser?.uid == uid ? Auth.auth().currentUser?.createProfileChangeRequest() : nil

        userRef?.displayName = displayName
        
        userRef?.commitChanges { error in
            if let error = error {
                // An error occurred while updating the display name
                print("Error updating display name: \(error.localizedDescription)")
            } else {
                // Display name updated successfully
                print("Display name updated successfully")
            }
        }
    }

}
