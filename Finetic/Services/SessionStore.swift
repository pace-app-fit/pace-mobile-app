//
//  SessionStore.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-21.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SessionStore: ObservableObject {
    @Published var currentUser = Auth.auth().currentUser
    @Published var isSignedIn = (Auth.auth().currentUser != nil)
    
//    var firestoreId = getUserId(userID: Auth.auth().currentUser?.uid ?? "")
    
    var firestoreID: DocumentReference {
        Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "")
    }
    
    func signup(firstname: String, lastName: String, email: String, password:String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMsg: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authData, err) in
            
            if let err = err as NSError? {
                switch AuthErrorCode(rawValue: err.code) {
                case .operationNotAllowed:
                    onError("This is not allowed")
                case .emailAlreadyInUse:
                    onError("This email is already in use")
                case .invalidEmail:
                    onError("Please enter a valid email")
                case .weakPassword:
                    onError("Please enter a stronger password")
                default:
                    onError("Something went very wrong...")
                }
            }
            
            guard let userId = authData?.user.uid else {return}
//            let firestoreID = self.getUserId(userID: userId)
            let user = User.init(uid: userId, email: email, firstName: firstname, lastName: lastName)
            
            guard let dict = try?user.asDictionary() else {return}
            
            self.firestoreID.setData(dict) { err in
                if err != nil {
                    print(err!.localizedDescription)
                }
            }
            
                
                
            }
            
        }
    
    
    func signin(email: String, password: String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                  onError("This isn't allowed")
                case .userDisabled:
                  onError("Your account has been disabled")
                case .wrongPassword:
                  onError("Wrong password or email")
                case .invalidEmail:
                    onError("Wrong password or email")
                default:
                    print("Error: \(error.localizedDescription)")
                }
                
            guard let userId = authData?.user.uid else {return}
//                let firestoreID = self.getUserId(userID: userId)
                print(self.firestoreID)
            
            
                self.firestoreID.getDocument {
                (document, error)  in
                
                if let dict = document?.data() {
                    guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                    onSuccess(decodedUser)
                }
                
            }

        }
        }}
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    
}
