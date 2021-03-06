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
        VStack {
            MapView(track: track)
                .frame(height: 350)
                
            Text(track.formattedDate)
                .font(.headline)
                .bold()
            HStack {
                VStack {
                    Text("Distance")
                    Text(track.formatedDistance)
                        .font(.title)
                }
                
                VStack {
                    Text("Time")
                    Text(track.formatedTime)
                        .font(.title)
                    
                }
            }
            Divider()
        }
        
    }
}

