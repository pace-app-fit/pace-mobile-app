//
//  NewRunMapViewCoordinator.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-08.
//

import Foundation
import Combine
import CoreLocation
import MapKit
import SwiftUI

class NewRunLocationManager: NSObject, ObservableObject {
    
    var newRun = TracksService()
    
    private var locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()
    var isRecording = false
    
    var locations = [NewLocation]()
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    @Published var lastLocation: CLLocation? {
        willSet {
            guard lastLocation != nil else {
                return
            }
            
            print(lastLocation)
            
            let currentCoordinates = NewCoords(speed: Double(lastLocation!.speed), heading: Double(lastLocation!.course), longitude: Double((lastLocation?.coordinate.longitude)!), accuracy: Double(lastLocation!.speedAccuracy), latitude: Double((lastLocation?.coordinate.latitude)!), altitude: Double(lastLocation!.altitude))
            let newLocation = NewLocation(coords: currentCoordinates)
            
            locations.append(newLocation)
        }
    }
    
    func createRun(name:String, coords: [NewLocation]) {
        let run = NewRun(name: name, locations: coords)
        locationManager.stopUpdatingLocation()
        
        newRun.postTracks(run: run)
        
    }
    
    func startRecording() {
        locationManager.startUpdatingLocation()
        isRecording = true
    }
    
    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "Unknown"
        }
        
        switch status {
                case .notDetermined: return "notDetermined"
                case .authorizedWhenInUse: return "authorizedWhenInUse"
                case .authorizedAlways: return "authorizedAlways"
                case .restricted: return "restricted"
                case .denied: return "denied"
                default: return "unknown"
                }
    }
    
    
    
    
    

      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3.0
        return renderer
      }
}

extension NewRunLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           self.locationStatus = status
           print(#function, statusString)
       }

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           self.lastLocation = location
           
       }
}
