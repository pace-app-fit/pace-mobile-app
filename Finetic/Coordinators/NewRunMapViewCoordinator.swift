//
//  NewRunMapViewCoordinator.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-22.
//
import SwiftUI
import MapKit

class NewRunMapViewCoordinator: NSObject, MKMapViewDelegate {
    private let map: NewRunMapView
    
    init(_ control: NewRunMapView) {
        self.map = control
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let latDelta:CLLocationDegrees = 0.5
        let lonDelta:CLLocationDegrees = 0.5
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
                        
    }

      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3.0
        return renderer
      }
}
