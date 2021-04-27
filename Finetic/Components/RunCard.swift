//
//  RunCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-05.
//

import SwiftUI

struct RunCard: View {
    var track: Run
    
    var body: some View {
        VStack(alignment: .leading) {
            
           
            Text(track.name)
                .font(.headline)
                .bold()
                .foregroundColor(.purple)
                .padding(.leading)
            
            HStack(spacing: 15) {
                RunStatComponent(label: "Distance", value: track.formatedDistance)
                Divider()
                RunStatComponent(label: "Time", value: track.formatedTime)
                Divider()
                RunStatComponent(label: "Pace", value: track.formatedPace)
                            
            }
            .padding(.leading)
            MapView(track: track)
                .frame(height: 270)
                .cornerRadius(cornerRadius)
                .padding()
            HStack(alignment: .center) {
                Spacer()
                NavigationLink(
                    destination: RunDetailsView(track: track),
                    label: {
                        Text("View More")
                            .foregroundColor(.secondary)
                            .bold()
                    })
                
                Spacer()
            }
                
            Divider()
          
        }
        
    }
    
    var cornerRadius = CGFloat(15)
    var largeNumber = CGFloat(42)
    var paddingSize = CGFloat(15)
}


