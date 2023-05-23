import UIKit
import Firebase

protocol HomeViewModelProtocol {
    func getUserPointsBalance(completion: @escaping(Int) -> Void)
    var pointsListener: ListenerRegistration? { get set }
}

class HomeViewModel: HomeViewModelProtocol {

    let uid: String = Auth.auth().currentUser?.uid ?? ""
    let database = Firestore.firestore()
    let userDocumentRef: DocumentReference?
    var pointsListener: ListenerRegistration?
    
    init() {
        userDocumentRef = database.collection("users").document(uid)
    }
    
    deinit {
        pointsListener?.remove()
    }
    
    func getUserPointsBalance(completion: @escaping(Int) -> Void) {
        pointsListener = userDocumentRef?.addSnapshotListener({ snapshot, error in
            if let error = error {
                print(error)
                return
            }
            if let data = snapshot?.data() {
                do {
                    let user = try JSONDecoder().decode(UserModel.self, fromJSONObject: data)
                    completion(user.points)
                }
                catch {
                    print(error)
                }
            }
        })
    }
}
