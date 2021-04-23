//
//  AuthService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-13.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userID: String) -> DocumentReference {
        return storeRoot.collection("users").document(userID)
    }
    
    static func signup(firstname: String, lastName: String, email: String, password:String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMsg: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authData, err) in
            
            if err != nil {
                onError(err!.localizedDescription)
                
                return
            }
            
            guard let userId = authData?.user.uid else {return}
            let firestoreID = getUserId(userID: userId)
            let user = User.init(uid: userId, email: email, firstName: firstname, lastName: lastName)
            
            guard let dict = try?user.asDictionary() else {return}
            
            firestoreID.setData(dict) { err in
                if err != nil {
                    print(err!.localizedDescription)
                }
            }
            
                
                
            }
            
        }
    
    
    static func signin(email: String, password: String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
            }
            guard let userId = authData?.user.uid else {return}
            let firestoreID = getUserId(userID: userId)

            
            
            firestoreID.getDocument {
                (document, error)  in
                
                if let dict = document?.data() {
                    guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                    onSuccess(decodedUser)
                }
                
            }

        }
    }
}
