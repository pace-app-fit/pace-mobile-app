//
//  NewRunMapViewCoordinator.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-22.
//
import SwiftUI
import MapKit
import CoreLocation
import Combine

class NewRunCoordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate, ObservableObject {
    var newRun: NewRun?
    var newLocations: [NewCoords]? = []
    var enabled = false
    var manager = CLLocationManager()
    var runService: RunsService = RunsService()
    var utilities = CreateRunHelperFunctions()
    
    override init() {
        super.init()
        manager.delegate = self
        
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
        let name = utilities.createName()
        let newRun = NewRun(name: name, locations: newLocations!)
        runService.postRun(newRun: newRun)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated")
        var nextCoordinate = NewCoords(speed: locations.last?.speed ?? 0.0, heading: locations.last?.course ?? 0.0, longitude: locations.last?.coordinate.longitude ?? 0.0, accuracy: locations.last?.horizontalAccuracy ?? 0.0, latitude: locations.last?.coordinate.latitude ?? 0.0, altitude: locations.last?.altitude ?? 0.0)
        newLocations?.append(nextCoordinate)
       
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        enabled = CLLocationManager.locationServicesEnabled()
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
                        
    }

    
}
