//
//  RunCard.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-05.
//

import SwiftUI

struct RunCardTrackInfo: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Distance")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("4.05 km")
                    .font(.title)
                    .italic()
                    .bold()
                
            }
            Divider()
        }
        .frame(height: 100)
    }
}

struct RunCardTrackInfo_Previews: PreviewProvider {
    static var previews: some View {
        RunCardTrackInfo()
    }
}


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
                VStack(alignment: .leading, spacing: 0){
                    Text("Distance")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(track.formatedDistance)
                        .font(.headline)
                        .italic()
                        .bold()
                        
                }
                Divider()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Time")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(track.formatedTime)
                        .font(.headline)
                        .italic()
                        .bold()
                }
                Divider()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Pace")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(track.formatedPace)
                        .font(.headline)
                        .italic()
                        .bold()
                }
                            
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


