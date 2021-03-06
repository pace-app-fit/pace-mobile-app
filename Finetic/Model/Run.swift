import Foundation
import MapKit

// MARK: - WelcomeElement
struct Run: Codable, Hashable {
    let name, id: String
    let locations: [Location]
    let userID: String
    let time, distance, averagePace, averageSpeed: Double
    let v: Int
    let createdAt: String
    let timestamp: String?
    
    var formatedTime: String {
        String(round(time))
    }
    
    var formatedDistance: String {
        String(round(distance))
    }
    
    var clCoordinates: [CLLocationCoordinate2D] {
        get {
            var coords = [CLLocationCoordinate2D]()
            for i in locations {
                coords.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(i.coords.latitude), longitude: CLLocationDegrees(i.coords.longitude)))
            }
            
            return coords
        }
    }

    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
        case locations
        case userID = "userId"
        case time, distance, averagePace, averageSpeed
        case v = "__v"
        case createdAt, timestamp
    }
}

// MARK: - Location
struct Location: Codable, Hashable {
    let coords: Coords
    let id: String
    let timestamp: Double

    enum CodingKeys: String, CodingKey {
        case coords
        case id = "_id"
        case timestamp
    }
}

// MARK: - Coords
struct Coords: Codable, Hashable {
    let speed, heading, longitude, accuracy: Double
    let latitude, altitude: Double
}




