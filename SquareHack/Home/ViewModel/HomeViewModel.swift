import UIKit
import Firebase
import FirebaseFirestore

protocol HomeViewModelProtocol {
    func getUserPointsBalance(completion: @escaping(Int) -> Void)
    func fetchFavourites(completion: @escaping ([FavouriteModel]) -> Void)
}

class HomeViewModel: HomeViewModelProtocol {
    
    let uid: String = Auth.auth().currentUser?.uid ?? ""
    let database = Firestore.firestore()
    var pointsListener: ListenerRegistration?
    
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
    
    func fetchFavourites(completion: @escaping ([FavouriteModel]) -> Void) {
        var favourites = [FavouriteModel]()
        let collectionRef = Firestore.firestore().collection("shops")
        collectionRef.getDocuments { (snapshot, error) in
            favourites.removeAll()
            if let error = error {
                print(error)
                return
            }
            
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()
                    do {
                        let favourite = try JSONDecoder().decode(FavouriteModel.self, fromJSONObject: data)
                        favourites.append(favourite)
                    }
                    catch {
                        print(error)
                    }
                    
                }
            }
            completion(favourites)
        }
    }
}
