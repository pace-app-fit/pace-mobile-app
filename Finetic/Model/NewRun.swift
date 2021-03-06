//
//  NewRun.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import SwiftUI
import MapKit

struct NewRun: Codable {
    var name: String
    var locations: [NewLocation]
}

struct NewLocation: Codable {
    var latitude, longitude, altitude, accuracy, heading, speed: Double
}
