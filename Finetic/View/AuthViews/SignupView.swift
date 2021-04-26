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
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no 😧"
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || firstName.trimmingCharacters(in: .whitespaces).isEmpty ||
            lastName.trimmingCharacters(in: .whitespaces).isEmpty{
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
        
        SessionStore().signup(firstname: firstName, lastName: lastName, email: email, password: password, onSuccess: {(user) in self.clear()}, onError: {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        })
        
    }
    
    func clear() {
        self.email = ""
        self.firstName = ""
        self.password = ""
        self.lastName = ""
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
                        FormField(value: $firstName, icon: "person", placeholder: "First name")
                        FormField(value: $lastName, icon: "person", placeholder: "Last name")
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


