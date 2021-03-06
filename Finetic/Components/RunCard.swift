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
                .frame(height: 350)
            Text(track.name)
                .font(.title)
                .bold()
                .foregroundColor(.purple)
                .padding(.leading)
            
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    
                    HStack(spacing: 0) {
                        Text(track.formatedTime)
                            .bold()
                            .font(.system(size: 50))
                        Text("min")
                            .foregroundColor(.secondary)
                            .padding(.top, 15)
                    }
                    Image("clock")
                }
                
                
                VStack(alignment: .center, spacing: 0){
                    
                    HStack(spacing: 0) {
                        Text(track.formatedDistance)
                            .bold()
                            .font(.system(size: 50))
                        Text("Km")
                            .foregroundColor(.secondary)
                            .padding(.top, 15)

                    }
                    Image("difficulty")
                }
                
            }
            .padding(.leading)
            
                
               
            
          
        }
        
    }
}

