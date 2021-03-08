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

         
      }

      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3.0
        return renderer
      }
}
