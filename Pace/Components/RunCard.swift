//
//  RunCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-05.
//

import SwiftUI
import URLImage

struct RunCard: View {
    var track: Run
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: UserProfileView(userId: track.user.id)) {
                HStack {
                    URLImage(url: URL(string: track.user.profileImage)!) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    }
                    VStack(alignment: .leading) {
                        Text(track.user.userName)
                            .bold()
                        Text(track.formatedCreatedDate)
                    }
                }

                .padding()
            }
            .buttonStyle(PlainButtonStyle())

            Text(track.name)
                .font(.headline)
                .bold()
                .foregroundColor(.purple)
                .padding(.leading)
            
            
            MapView(track: track)
                .frame(height: 270)
               
            HStack(spacing: 15) {
                RunStatComponent(label: "Distance", value: track.formatedDistance)
                Divider()
                RunStatComponent(label: "Time", value: track.formatedTime)
                Divider()
                RunStatComponent(label: "Pace", value: track.formatedPace)
                if track.weather != nil {
                    Divider()
                    RunStatComponent(label: "Temp", value: track.formatedTemperature)
                }
               
                            
            }
            .padding(.leading)
            .frame(maxHeight: 50)
        
            NavigationLink(
                destination: RunDetailsView(track: track),
                label: {
                    Text("View More")
                        .foregroundColor(.secondary)
                        .bold()
                })
                .padding(.horizontal)            
          
    }
        .frame(height: 475)
        .padding(.bottom)
}

}
