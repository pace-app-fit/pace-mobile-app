//
//  MapView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-05.
//

import SwiftUI
import MapKit
import Combine

struct MapView: UIViewRepresentable {
    var track: Run
    var locationManager = CLLocationManager()
    
    func setupManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        
        return MapViewCoordinator(self)
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        return mapView
      }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateOverlays(from: uiView)
    }

    func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: track.clCoordinates, count: track.locations.count)
        mapView.addOverlay(polyline)

    }
    
    
   
    
}

