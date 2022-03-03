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
    @Published var lineCoordinates: [CLLocationCoordinate2D] = []
    var enabled = false
    var manager = CLLocationManager()
    var runService: RunsService = RunsService()
    var session = SessionStore()
    var utilities = CreateRunHelperFunctions()
    
    @Published var region: MKCoordinateRegion?
    var span: MKCoordinateSpan?
    
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
        let newRun = NewRun(name: name, coordinates: newLocations!)
        runService.postRun(newRun: newRun)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated")
        let nextCoordinate = NewCoords(speed: locations.last?.speed ?? 0.0, longitude: locations.last?.coordinate.longitude ?? 0.0, accuracy: locations.last?.horizontalAccuracy ?? 0.0, latitude: locations.last?.coordinate.latitude ?? 0.0, altitude: locations.last?.altitude ?? 0.0)
        let nextLine = CLLocationCoordinate2D(latitude: locations.last?.coordinate.latitude ?? 0.0, longitude: locations.last?.coordinate.longitude ?? 0.0)
        newLocations?.append(nextCoordinate)
        lineCoordinates.append(nextLine)
        region = MKCoordinateRegion(center: nextLine, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
       
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        enabled = CLLocationManager.locationServicesEnabled()
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) -> MKMapView{
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        self.region = region
        self.span = span
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .blue
      renderer.lineWidth = 3.0
      return renderer
    }

    
}
