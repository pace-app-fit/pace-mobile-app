import Foundation
import MapKit

// MARK: - WelcomeElement
struct Run: Codable, Hashable, Equatable {
    let name, id, userId, createdAt: String
    let coordinates: [Coordinate]
    let time, distance, averagePace, averageSpeed: Double
    let totalElevation: TotalElevation

    
    var formatedTime: String {
        let minutes = String(format: "%g", round(time / 60))
        let seconds = String(format: "%g", round(time.truncatingRemainder(dividingBy: 60)))
        return String("\(minutes):\(seconds) min")
    }
    
    var formatedDistance: String {
       "\(String(format: "%.2f", distance)) km"
    }
    
    var formatedPace: String {
        let minutes = averagePace.rounded(.down)
        let wholeMinutes = String(format: "%g", minutes)
        let seconds = ((averagePace-minutes)*60).rounded(.up)
        let wholeSeconds = String(format: "%g", seconds)
        return String("\(wholeMinutes):\(wholeSeconds) min / km")
    }
    
    var formatedCreatedDate: String {
//        let date = Date(timeIntervalSinceReferenceDate: createdAt)
//        return date.getFormattedDate(format: "EEEE, MMM d, yyyy")
        return createdAt
    }
    
    var formatedSpeed: String {
        let speed = String(format: "%.2f", averageSpeed)
        return "\(speed) km/h"
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
            for i in coordinates {
                coords.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(i.latitude), longitude: CLLocationDegrees(i.longitude)))
            }
            
            return coords
        }
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


// MARK: - Coords
struct Coordinate: Codable, Hashable, Equatable {
    let latitude, longitude, accuracy, altitude: Double
}

struct UnitAnalysis: Codable, Hashable, Equatable {
    let km: Int
    let elevation, pace: Double
    var kmAsString: String {
        String(format: "%.2f", km)
    }
    
    var paceAsString: String {
        String(format: "%.2f", pace)
    }
    
    var elevationAsString: String {
        String(format: "%.2f", elevation)
    }
}


struct TotalElevation: Codable, Equatable, Hashable {
    let positive, negative, netElevation: Double
    
    var totalElevationAsString: String {
        "\(String(format: "%.2f", netElevation)) m"
    }
}




