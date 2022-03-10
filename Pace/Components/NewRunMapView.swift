//
//  NewRunMapView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-22.
//

import SwiftUI
import MapKit
import Combine

struct NewRunMapView: UIViewRepresentable {
   
    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeOverlays(view.overlays)
        view.region = region
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        view.addOverlay(polyline)
        view.setRegion(region, animated: true)

    }

      // Link it to the coordinator which is defined below.
    func makeCoordinator() -> NewRunMapViewCoordinator {
        NewRunMapViewCoordinator(self)
    }
    
   
}

class NewRunMapViewCoordinator: NSObject, MKMapViewDelegate {
  var parent: NewRunMapView

  init(_ parent: NewRunMapView) {
    self.parent = parent
  }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let routePolyline = overlay as? MKPolyline {
        let renderer = MKPolylineRenderer(polyline: routePolyline)
        renderer.strokeColor = UIColor.systemBlue
        renderer.lineWidth = 5
        return renderer
      }
      return MKOverlayRenderer()
    }
}
    
    
   
    
   

    

