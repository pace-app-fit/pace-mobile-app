//
//  UserProfile.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import SwiftUI

struct UserProfile: View {
    @State private var value: String = ""
    @State var users: [User] = []
    @State var isLoading = false
    
    func searchUsers() {
        isLoading = true
        SearchService("").searchUser(input: value) { users in
            self.isLoading = false
            self.users = users
            print(users)
        }
            
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(searchUsers: $value)
                    .padding()
                    .onChange(of: value, perform: { new in
                        searchUsers()
                       
                    })
                if !isLoading {
                    ForEach(users, id: \.id) { user in
                        HStack {
                            Text(user.email)
                        }
                    }
                }
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
