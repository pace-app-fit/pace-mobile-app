//
//  SearchService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SearchService: ObservableObject {
    var db = Firestore.firestore()
    @Published var name = ""
    func searchUser(input: String, onSucess: @escaping (_ user: [User]) -> Void) {
        Firestore.firestore().collection("users").whereField("searchName", arrayContains: input.lowercased().removeWhiteSpaces()).getDocuments { (querySnapshot, err) in
            
            guard let snap = querySnapshot else {return print("Error: \(err?.localizedDescription)")}
            
            var users = [User]()
            for doc in snap.documents {
                guard let decoded = try? User(fromDictionary: doc.data()) else {return}
                
                if decoded.uid != Auth.auth().currentUser?.uid {
                    users.append(decoded)
                }

            }
            
            onSucess(users)
            
        }
    }


    func searchUserById(_ uid: String) {
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
    
            guard let snap = querySnapshot else {return print("Error: \(err?.localizedDescription ?? "err with snap")")}
            
            guard let decodedUser = try? User(fromDictionary: snap.documents.first?.data()) else {return}
            let firstName = decodedUser.firstName.capitalized
            let lastName = decodedUser.lastName.capitalized
            self.name = "\(firstName) \(lastName)"
        }
    }
    
    init(_ uid: String) {
        searchUserById(uid)
        print(self.name)
    }
    
   
    
}
