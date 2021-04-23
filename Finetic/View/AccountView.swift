//
//  AccountView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var session: SessionStore
    
    func signOut() {
        session.logout()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    HStack{
                        Text(session.session?.firstName.capitalized ?? "Log in")
                            .font(.headline)
                        Spacer()
                            
                    }
                    HStack{
                        Text(session.session?.email ?? "Log in")
                            .font(.headline)
                        Spacer()
                            
                    }
                        
                }
                
                Section(header: Text("Log out")) {
                    Text("Signout")
                        .onTapGesture(perform: signOut)
                }
            }
            .navigationTitle("Account")
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
