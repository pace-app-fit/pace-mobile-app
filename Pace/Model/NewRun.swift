//
//  NewRun.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import Foundation
import MapKit

// MARK: - WelcomeElement
struct NewRun: Codable, Hashable {
    var name: String
    var id = UUID()
    var coordinates: [NewCoords]
    var distance: Double
    var weather: Current?

}

// MARK: - Coords
struct NewCoords: Codable, Hashable {
    var speed, longitude, accuracy: Double
    var latitude, altitude: Double
    var createdAt = Date()
}




