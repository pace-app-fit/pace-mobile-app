//
//  AccountView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    HStack{
                        Text("Name")
                            .font(.headline)
                        Spacer()
                        Text(session.user?.fullName.capitalized ?? "Unknown Figure")
                            
                    }
                    HStack{
                        Text("Email")
                            .font(.headline)
                        Spacer()
                        Text(session.user?.email ?? "Unknown Email")
                            
                    }
                        
                }
                
                Section(header: Text("Log out")) {
                    Text("Signout")
                        .onTapGesture {
                            session.signout()
                        }
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
