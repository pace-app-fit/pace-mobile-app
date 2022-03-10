//
//  ContentView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-22.
//

import SwiftUI
import MapKit
import Combine
import Resolver
import URLImage

struct RunsView: View {
    @ObservedObject var social = SocialService()
    @ObservedObject var tracks = RunsService()
    @State private var value: String = " "
    @State var users: [User] = []
    @State var searchText = ""
   
    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView {
                ScrollView {
                    if(social.loading) {
                        ProgressView()
                            .padding(.top, 200)
                    } else {
                        if #available(iOS 15.0, *) {
                            ForEach(tracks.feed, id: \.self) { track in
                                RunCard(track: track)
                            }
                            .onChange(of: self.searchText) { value in
                                social.searchUsers(searchText: value)
                            }
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                .onAppear(perform: tracks.getFeed)
                .onAppear(perform: social.getAllUsers)
                .navigationTitle("Friends")
                .searchable(text: $searchText) {
                        ForEach(social.users, id: \.self) { user in
                            NavigationLink(destination: UserProfileView(userId: user.id)) {
                                    HStack {
                                        URLImage(url: URL(string: user.profileImage)!) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 60)
                                                .cornerRadius(50)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(user.userName)
                                                .font(.headline)
                                            Text(user.name)
                                                .foregroundColor(.secondary)
                                            
                                        }
                                    }
                                    .searchCompletion(user.userName)
                            }
                            .buttonStyle(PlainButtonStyle())
                           
                        }
                    }
                }
            .navigationViewStyle(StackNavigationViewStyle())
            }
         else {
            // Fallback on earlier versions
        }
       
    }
}




