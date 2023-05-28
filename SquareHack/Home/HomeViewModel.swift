import UIKit
import Firebase
import FirebaseFirestore

protocol HomeViewModelProtocol {
    func getUserPointsBalance(completion: @escaping(Int) -> Void)
    func fetchFavourites(completion: @escaping (Error?) -> Void)
    var pointsListener: ListenerRegistration? { get set }
    var favourites: [Favourite] { get }
}

class HomeViewModel: HomeViewModelProtocol {
        
    let uid: String = Auth.auth().currentUser?.uid ?? ""
    let database = Firestore.firestore()
    var pointsListener: ListenerRegistration?
    var favouritesListener: ListenerRegistration?
    var rewards = [Reward]()
    var favourites = [Favourite]()
    
    func getUserPointsBalance(completion: @escaping(Int) -> Void) {
        pointsListener = database.collection("users").document(uid).addSnapshotListener({ snapshot, error in
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

    func fetchFavourites(completion: @escaping (Error?) -> Void) {
        let collectionRef = Firestore.firestore().collection("shops")
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            self.favourites.removeAll()
            for document in snapshot?.documents ?? [] {
                print(document.data())
                let name = document["name"] as? String ?? ""
                let type = document["type"] as? String ?? ""
                
                let favourite = Favourite(image: "github", logo: "github", title: name, type: type)
                self.favourites.append(favourite)
            }
            completion(nil)
        }
    }
}
