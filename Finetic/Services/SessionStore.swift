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
import FirebaseFirestoreSwift

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var currentUser = Auth.auth().currentUser
    @Published var isSignedIn = (Auth.auth().currentUser != nil)
    var db = Firestore.firestore()
    
    func listen () {
            handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                    print("Got user: \(user.email!)")
                    let userDocument = self.db.collection("users").document(user.uid)
                    userDocument.getDocument { (doc, err) in
                        guard let decodedUser = doc?.data() else {return}
                        self.session = try? User(fromDictionary: decodedUser)
                        
                    }
                    
                } else {
                    self.session = nil
                }
            }
        }
    
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
            let newUser = User(uid: userId, email: email, firstName: firstname, lastName: lastName)
            
            guard let dict = try?newUser.asDictionary() else {return}
            
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
    
    func logout()  {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
        }
    }
    
    func unbind () {
            if let handle = handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    
    
}
