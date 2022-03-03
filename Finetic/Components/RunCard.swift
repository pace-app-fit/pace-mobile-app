//
//  RunCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-05.
//

import SwiftUI

struct RunCard: View {
    var track: Run
    
    init(track: Run) {
        self.track = track

    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 45)
                VStack(alignment: .leading) {
//                    Text(search.name)
//                        .bold()
                    Text(track.formatedCreatedDate)
                }
            }
            .padding()
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
