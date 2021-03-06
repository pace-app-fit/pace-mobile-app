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
    
    var centerPoint: CLLocationCoordinate2D {
        calculateCenter(coordinates: clCoordinates)
    }
    
    var latSpan: Double {
        distance * 0.5 * 1000
    }
    
    var lonSpan: Double {
        distance * 0.3 * 1000
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
    
    func calculateCenter(coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        var x: Double = 0
        var y: Double = 0
        var z: Double = 0
        
        for coordinate in coordinates {
            let lat = coordinate.latitude * Double.pi / 180
            let long = coordinate.longitude * Double.pi / 180
            
            x += cos(lat) * cos(long)
            y += cos(lat) * sin(long)
            z += sin(lat)
        }
        
        let total = Double(coordinates.count)
        x = x / total
        y = y / total
        z = z / total
        
        let centralLongitude = atan2(y, x)
        let centralSquareRoot = sqrt(x*x + y*y)
        let centralLatitude = atan2(z, centralSquareRoot)
        
        return CLLocationCoordinate2D(latitude: centralLatitude * 180 / Double.pi, longitude: centralLongitude * 180 / Double.pi)
        
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




