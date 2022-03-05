//
//  ContentView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-22.
//

import SwiftUI
import MapKit
import Combine

struct RunsView: View {
    
    @ObservedObject var tracks = RunsService()
    @State private var value: String = " "
    @State var users: [User] = []
    @State var isLoading = false
    
    func searchUsers() {
        isLoading = true
        SearchService(" ").searchUser(input: value) { users in
            self.isLoading = false
            self.users = users
            print(users)
        }
            
    }
   
    var body: some View {
        NavigationView {
            ScrollView {
                if(tracks.loading) {
                    ProgressView()
                        .padding(.top, 200)
                } else {
                    ForEach(tracks.feed, id: \.self) { track in
                        RunCard(track: track)
                    }
                }
            }
            .onAppear(perform: tracks.getFeed)
            .navigationTitle("Friends")
        }
    }
}




