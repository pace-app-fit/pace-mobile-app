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
    
    @ObservedObject var tracks = TracksService()
   
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(tracks.previousRuns!, id: \.self) { track in
                        RunCard(track: track)

                    }
                    
                    
                }
            }
            
            .navigationTitle("Previous Runs")
            
        }
            
    }
}




