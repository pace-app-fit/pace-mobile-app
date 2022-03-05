//
//  SignupView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-13.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var userName = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no 😧"
    @EnvironmentObject var auth: SessionStore

    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || name.trimmingCharacters(in: .whitespaces).isEmpty ||
            userName.trimmingCharacters(in: .whitespaces).isEmpty{
            return "Please fill in all fields and provide a profile image"
        }
        return nil
    }
    
    func signup() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        auth.signup(name: name, userName: userName, email: email, password: password)
        
    }
    
    func clear() {
        self.email = ""
        self.name = ""
        self.password = ""
        self.userName = ""
    }
    
    

    var body: some View {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Welcome")
                            .font(.system(size: 24, weight: .heavy))
                        Text("Signup to start")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                   
                    FormField(value: $name, icon: "person", placeholder: "Enter your", name: "Name")
                    FormField(value: $userName, icon: "person", placeholder: "Enter your User Name", name:"User Name")
                    FormField(value: $email, icon: "mail", placeholder: "me@gmail.com", name: "Email")
                    FormField(value: $password, icon: "lock", placeholder: "Choose a secure password", isSecure: true, name: "Password")
                    
                    Spacer()
                    Button(action: {signup()}, label: {
                    Text("Sign up")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .modifier(ButtonModifier())
                    
                    })
                    .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding([.leading, .trailing], 20)

    }
}


