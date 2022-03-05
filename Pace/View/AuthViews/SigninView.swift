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
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no 😧"
    @EnvironmentObject var auth: SessionStore
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill in all fields"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signin() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        auth.login(email: email, password: password,  onSuccess: {
            (user) in
            print(user.email)
            self.clear()
        }, onError: {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        })
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
               
                VStack(alignment: .center) {
                    Text("Welcome Back")
                        .font(.system(size: 32, weight: .heavy))
                    Text("Sign in to continue")
                        .font(.system(size: 16, weight: .medium))
                    
                }
                
                FormField(value: $email, icon: "mail", placeholder: "Enter email")
                FormField(value: $password, icon: "lock", placeholder: "Enter password", isSecure: true)
                
                Button(action: {
                    signin()
                }, label: {
                    Text("Sign in")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .modifier(ButtonModifier())
                    
                }).alert(isPresented: $showingAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                })
                
                HStack {
                    Text("New?")
                    NavigationLink(destination: SignupView()) {
                        Text("Create an account here").bold()
                    }
                }
                .font(.callout)
            }.padding().navigationBarHidden(true)
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
