//
//  User.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation
import Firebase
import FirebaseFirestore

class User: Encodable, Decodable {
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var searchName: [String]
//    var firestoreId: DocumentReference {
//        Firestore.firestore().collection("users").document(uid)
//    }
    
    init(uid: String, email: String, firstName: String, lastName: String) {
        self.email = email
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.searchName = firstName.splitString()
    }
    
}
