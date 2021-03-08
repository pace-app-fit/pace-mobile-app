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
    var locations: [NewLocation]
    
}

// MARK: - Location
struct NewLocation: Codable, Hashable {
    var coords: NewCoords
    var id = UUID()

    enum CodingKeys: String, CodingKey {
        case coords
        case id = "_id"
    }
}

// MARK: - Coords
struct NewCoords: Codable, Hashable {
    var speed, heading, longitude, accuracy: Double
    var latitude, altitude: Double
}




