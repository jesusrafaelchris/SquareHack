//
//  DiscoverViewModel.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 27/05/2023.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol DiscoverViewModelProtocol {
    func fetchRecommends(completion: @escaping (Error?) -> Void)
    var recommends: [Recommended] { get }
}

class DiscoverViewModel: DiscoverViewModelProtocol {
        
    let uid: String = Auth.auth().currentUser?.uid ?? ""
    let database = Firestore.firestore()
    var favouritesListener: ListenerRegistration?
    var recommends = [Recommended]()
    
    func fetchRecommends(completion: @escaping (Error?) -> Void) {
        let collectionRef = Firestore.firestore().collection("shops")
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            self.recommends.removeAll()
            for document in snapshot?.documents ?? [] {
                print(document.data())
                let name = document["name"] as? String ?? ""
                let type = document["type"] as? String ?? ""
                
                let recommend = Recommended(image: "github", logo: "mcdondalds", title: name, type: type)
                self.recommends.append(recommend)
            }
            completion(nil)
        }
    }
}

