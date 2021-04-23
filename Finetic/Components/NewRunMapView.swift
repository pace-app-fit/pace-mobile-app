//
//  NewRunMapView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-22.
//

import Foundation
import MapKit
import SwiftUI
import Combine

struct NewRunMapView: UIViewRepresentable{
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //more code
    }
    
    var locationManager = CLLocationManager()
    
    func setupManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeCoordinator() -> NewRunMapViewCoordinator {
        
        return NewRunMapViewCoordinator(self)
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
      
        return mapView
      }
    
   
    
   

    
}
