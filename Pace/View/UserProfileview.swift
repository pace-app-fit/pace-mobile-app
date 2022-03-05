//
//  UserProfileview.swift
//  Pace
//
//  Created by Tapiwa Kundishora on 2022-03-05.
//

import Foundation
import SwiftUI
import URLImage

struct UserProfileView: View {
    @EnvironmentObject var auth: SessionStore
    @ObservedObject var social = SocialService()
    var userId: String
    
    var body: some View {
       
            ScrollView {
                Group {
                    if (social.loading) {
                        ProgressView()
                            .padding(.top, 200)

                    } else {
                        if(social.runs.count < 1) {
                            VStack {
                                Text("This user has no runs...")
                                    .foregroundColor(.secondary)
                                    .font(.title)
                                    .bold()
                                Text("Tell them to run 😂")
                                    .foregroundColor(.secondary)
                                   
                            }
                            .frame(width: 340, height: 200)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                            .padding(.top, 200)
                        } else {
                            ForEach(social.runs, id: \.self) { track in
                                RunCard(track: track)
                            }
                        }
                    }
                }
            }
            .onAppear {
                social.getUser(userId: userId)
                social.getUserRuns(userId: userId)
            }
            .navigationTitle("\(social.user?.userName ?? "User")'s runs")
        
    }
}

