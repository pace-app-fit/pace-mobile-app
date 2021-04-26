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
    var locations: [NewCoords]
    var createdAt = Date()
    
}

// MARK: - Coords
struct NewCoords: Codable, Hashable {
    var speed, heading, longitude, accuracy: Double
    var latitude, altitude: Double
    var id = UUID()
    var createdAt = Date()
}




