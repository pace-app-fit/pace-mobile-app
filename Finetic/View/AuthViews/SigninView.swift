//
//  SigninView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import SwiftUI

struct SigninView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var session: SessionStore
    
    
    var body: some View {
        NavigationView {
            VStack {
                FormField(value: $email, icon: "mail", placeholder: "Enter email")
                FormField(value: $password , icon: "lock", placeholder: "Enter password")
                
                Button("Sign in") {
                    session.signin(email: email, password: password)
                }
            }
            
            
        }
    }
    
    func signin() {
        
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill in all fields"
        }
        return nil
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
