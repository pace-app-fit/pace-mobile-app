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
        
        SessionStore().signup(name: name, userName: userName, email: email, password: password)
        
    }
    
    func clear() {
        self.email = ""
        self.name = ""
        self.password = ""
        self.userName = ""
    }
    
    

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                
                    VStack(alignment: .center) {
                        Text("Welcome")
                            .font(.system(size: 32, weight: .heavy))
                        Text("Signup to start")
                            .font(.system(size: 16, weight: .medium))
                        
                    }
                    
                    VStack {
                      
                    Group {
                        FormField(value: $name, icon: "person", placeholder: "Name")
                        FormField(value: $userName, icon: "person", placeholder: "User Name")
                        FormField(value: $email, icon: "mail", placeholder: "Email")
                        FormField(value: $password, icon: "lock", placeholder: "Password", isSecure: true)
                    }
                    
                
                    
                        Button(action: {signup()}, label: {
                        Text("Sign up")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .modifier(ButtonModifier())
                        
                        }).alert(isPresented: $showingAlert, content: {
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                        })
                    
                    HStack {
                        Text("Already have an account?")
                        NavigationLink(destination: SigninView()) {
                            Text("Sign in").bold()
                        }
                    }
                    .font(.callout)
                }.padding()
                }
                
            }.navigationBarHidden(true)
        }
       
    }
}


