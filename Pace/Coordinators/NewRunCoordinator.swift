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

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

class NewRunCoordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate, ObservableObject {
    var network = NetworkMonitor()
    var newRun: NewRun?
    var newLocations: [NewCoords] = []
    var currentWeather: Current?
    @Published var lineCoordinates: [CLLocationCoordinate2D] = []
    private var localCoordinates:[CLLocation] = []
    @Published var distance = 0.0
    @Published var speed = 0.0
    @Published var city = ""
    var enabled = false
    var manager = CLLocationManager()
    var runService: RunsService = RunsService()
    var session = SessionStore()
    var utilities = CreateRunHelperFunctions()
    var weatherCLient = WeatherService()
    @Published var loading = false
    private var hasFetchedWeather = false

    @Published var region: MKCoordinateRegion?
    var span: MKCoordinateSpan?
    
    override init() {
        super.init()
        manager.delegate = self
        
    }
    
    func start() {
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
        manager.activityType = CLActivityType.fitness
        manager.showsBackgroundLocationIndicator = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        network.startMonitoring()
        
    }
    
    func stop(completion: @escaping (Result<Run, ServerError>) -> Void) throws {
        self.loading = true
        manager.stopUpdatingLocation()
        let name = utilities.createName()
        let newRun = NewRun(name: name, coordinates: newLocations, distance: distance, weather: currentWeather)
        if(!network.isReachable) {
            self.saveToDevice(run: newRun)
            throw "You're not connected to the internet"
        }
        if(newRun.coordinates.count < 4) {
            throw "Sorry this run isnt long enough"
        }
        runService.postRun(newRun: newRun) { res in
            completion(res)
            switch res {
            case .success(_):
                print("")
            case .failure(_):
                self.saveToDevice(run: newRun)
            }
        }
        self.loading = false
    }
    
    func saveToDevice(run: NewRun) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(run)
            UserDefaults.standard.set(data, forKey: "run")

        } catch {
            print("Unable to Encode run (\(error))")
        }
      
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("LOCATION UPDATED")
            let nextCoordinate = NewCoords(speed: location.speed , longitude: location.coordinate.longitude , accuracy: location.horizontalAccuracy , latitude: location.coordinate.latitude, altitude: location.altitude )
            newLocations.append(nextCoordinate)
            lineCoordinates.append(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            localCoordinates.append(location)
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            print(location.speed)
            print(location.speedAccuracy)

            self.updateDistance()
            self.speed = location.speed
            
            if(!hasFetchedWeather) {
                print( String(format: "%f",location.coordinate.latitude))
                weatherCLient.getWeather(lat: String(format: "%f",location.coordinate.latitude), long: String(format: "%f", location.coordinate.longitude) ) { weather in
                    self.currentWeather = weather.current
                    self.hasFetchedWeather = true
                }
                
            }
        }
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
    
    func updateDistance() {
        var d = 0.0
        for i in 1..<localCoordinates.count {
            let previousCoordinate = localCoordinates[i - 1]
            let curentCoordinate = localCoordinates[i]
            d += curentCoordinate.distance(from: previousCoordinate)
        }
        self.distance = d * 0.001
    }
    
    
    
}
