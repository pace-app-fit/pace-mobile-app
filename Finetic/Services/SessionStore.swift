//
//  SessionStore.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation
import Combine
import Alamofire

class SessionStore: ObservableObject {
    @Published var isAuthorized = false
    @Published var user: User?
    
    
    var token: String {
        return user?.token ?? ""
    }
    
    let root = "https://1bcfb1cbeb0c.ngrok.io"
    
    
    func signin(email: String, password: String) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request("\(root)/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (res) in
                let body = res.value as! NSDictionary
                let token = body["token"] as! String
               
                self.isAuthorized = true
                self.user?.token = token
                
                
                                
                UserDefaults.standard.set(token, forKey: "token")
            }
    }
    
    func tryLocalSignin() {
        let token = UserDefaults.standard.string(forKey: "token")
       
        if let token = token {
            var email: String = ""
            var firstName: String = ""
            var lastName: String = ""
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
            
            AF.request("\(root)/get-users", headers: headers)
                .responseJSON { res in
                    
                    let body = res.value as! NSDictionary
                    email = body["email"] as! String
                    firstName = body["firstName"] as! String
                    lastName = body["lastName"] as! String
                    
                    self.user = User(email: email, token: token, firstName: firstName, lastName: lastName)
                    
                    
                }
            self.isAuthorized = true
            
        }
        
    }
    
    func signout() {
        UserDefaults.standard.removeObject(forKey: "token")
        self.isAuthorized = false
    }
    
    init() {
        tryLocalSignin()
        
    }
}
