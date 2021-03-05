//
//  LocationManager.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var locations: [CLLocation]?
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.locations = locations
        }
    }
}
