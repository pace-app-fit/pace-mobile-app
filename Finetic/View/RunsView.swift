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
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?
    
    private func setCurrentLocation() {
        cancellable = locationManager.$locations.sink { location in
            region = MKCoordinateRegion(center: location?.last?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {

                List {
                    ForEach(tracks.previousRuns!, id: \.self) { track in
                        Text(track.name)
                    }
                }
            }
            .navigationTitle("Previous Runs")
        }
        
//        .onAppear {
//            setCurrentLocation()
//            tracks.fetchTracks()
//        }
     
            
    }
}

//            if locationManager.locations != nil {
//                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil)
//
//            } else {
//                Text("Locating user location...")
//            }


