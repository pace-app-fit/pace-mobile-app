//
//  SessionStore.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-21.
//

import Foundation
import Combine
import Alamofire

class SessionStore: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn: Bool? = nil
    private var host = "http://3.96.220.190:3000"
    
    func signup(name: String,
                userName: String,
                email: String,
                password:String
               ) {
        print("signing up...")
        let newUser = ["name": name, "userName": userName, "password": password, "email": email]
        AF.request("\(host)/api/v1/users/register", method: .post, parameters: newUser, encoder: JSONParameterEncoder.default).responseDecodable(of: Session.self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(response.error)")
            }
            guard let user = response.value?.user else {return}
            
            self.objectWillChange.send()
            self.user = user
            self.isSignedIn = true
            UserDefaults.standard.set(response.value?.token, forKey: "token")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set(user.id, forKey: "userId")
        }
        
    }
    
    func login(email: String,
                password:String,
               onSuccess: ((_ user: User) -> Void)? = nil,
               onError: ((_ errorMsg: String) -> Void)? = nil) {
        let user = ["email":email, "password":password]
        
        AF.request("\(host)/api/v1/users/login", method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: Session.self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(response.error)")
                if(onError != nil) {
                    onError!(response.error?.localizedDescription ?? "something went wrong")
                }
            }
            guard let user = response.value?.user else {return}
            print(self.isSignedIn)

            self.objectWillChange.send()
            self.user = user
            self.isSignedIn = true
            
            print(self.isSignedIn)
            UserDefaults.standard.set(response.value?.token, forKey: "token")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set(user.id, forKey: "userId")
            if(onSuccess != nil) {
                onSuccess!(user)
            }
        }
    }
    
    func localSignin() {
        print("local signin...")
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        if(email != nil && password != nil) {
            login(email: email!, password: password!)
        } else {
            self.isSignedIn = false
        }
    }
    
    func logout() {
        
        UserDefaults.standard.reset()
        self.isSignedIn = false
    }
}

extension UserDefaults {

    enum Keys: String, CaseIterable {

        case token
        case email
        case password
        case userId

    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}

