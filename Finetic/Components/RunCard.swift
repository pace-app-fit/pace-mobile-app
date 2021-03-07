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
            
            MapView(track: track)
                .frame(height: 270)
                .cornerRadius(cornerRadius)
                .padding()
            Text(track.name)
                .font(.title)
                .bold()
                .foregroundColor(.purple)
                .padding(.leading)
            
            HStack(spacing: 50) {
                VStack(alignment: .center, spacing: 0) {
                    
                    HStack(spacing: 0) {
                        Text(track.formatedTime)
                            .bold()
                            .font(.system(size: largeNumber))
                        Text("min")
                            .foregroundColor(.secondary)
                            .padding(.top, paddingSize)
                    }
                    Text("Time")
                        .foregroundColor(.secondary)
                        .bold()
                }
                
                
                VStack(alignment: .center, spacing: 0){
                    HStack(spacing: 0) {
                        Text(track.formatedDistance)
                            .bold()
                            .font(.system(size: largeNumber))
                        Text("Km")
                            .foregroundColor(.secondary)
                            .padding(.top, paddingSize)
                    }
                    Text("Distance")
                        .foregroundColor(.secondary)
                        .bold()
                }
                
            }
            .padding(.leading)
            
                
               
            Divider()
          
        }
        
    }
    
    var cornerRadius = CGFloat(15)
    var largeNumber = CGFloat(42)
    var paddingSize = CGFloat(15)
}

