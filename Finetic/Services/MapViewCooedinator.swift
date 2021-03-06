//
//  MapViewCooedinator.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-05.
//

import SwiftUI
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    private let map: MapView
    
    init(_ control: MapView) {
        self.map = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.0703746, longitude: 114.2218712), latitudinalMeters: 50, longitudinalMeters: 50)
            mapView.setRegion(region, animated: true)
         
      }

      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3.0
        return renderer
      }
}
