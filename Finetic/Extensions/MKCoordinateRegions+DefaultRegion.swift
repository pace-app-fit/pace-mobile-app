//
//  MKCoordinateRegions+DefaultRegion.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 51.070389, longitude: -114.221519), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
