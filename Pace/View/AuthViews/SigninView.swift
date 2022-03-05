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
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Welcome Back")
                        .font(.system(size: 24, weight: .heavy))
                        .font(.title)
                    Text("Sign in to continue")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                }
                FormField(value: $email, icon: "mail", placeholder: "me@gmail.com", name: "Email")
                FormField(value: $password, icon: "lock", placeholder: "Enter your password", isSecure: true, name: "Password")
                Spacer()
                Button(action: {
                    signin()
                }, label: {
                    Text("Sign in")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .modifier(ButtonModifier())
                    
                }).alert(isPresented: $showingAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding([.leading, .trailing], 20)
        
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
