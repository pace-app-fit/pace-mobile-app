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
    
   
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(tracks.runs ?? [], id: \.self) { track in
                        RunCard(track: track)

                    }
                    
                    
                }.onAppear(perform: tracks.fetchRuns)
                
            }
            .navigationTitle("Previous Runs")
            
            
        }
        .background(Color(UIColor.lightGray))
            
    }
}




