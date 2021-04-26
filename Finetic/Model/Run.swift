import Foundation
import MapKit

// MARK: - WelcomeElement
struct Run: Codable, Hashable {
    let name, id: String
    let locations: [Location]
    let time, distance, averagePace, averageSpeed: Double
    let createdAt: Double
    
    var formatedTime: String {
        let minutes = String(format: "%g", round(time / 60))
        let seconds = String(format: "%g", round(time.truncatingRemainder(dividingBy: 60)))
        return String("\(minutes):\(seconds) min")
    }
    
    var formatedDistance: String {
       "\(String(format: "%.2f", distance)) km"
    }
    
    var formatedPace: String {
        var minutes = averagePace.rounded(.down)
        var wholeMinutes = String(format: "%g", minutes)
        let seconds = ((averagePace-minutes)*60).rounded(.up)
        let wholeSeconds = String(format: "%g", seconds)
        return String("\(wholeMinutes):\(wholeSeconds)min / km")
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
    
//    var formattedDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yy"
//        let date = dateFormatter.date(from: createdAt)
//        return String("\(date ?? Date())")
//    }
    
    
    
    var clCoordinates: [CLLocationCoordinate2D] {
        get {
            var coords = [CLLocationCoordinate2D]()
            for i in locations {
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
struct Location: Codable, Hashable {
    let speed, altitude, accuracy: Double
    let latitude, longitude, createdAt: Double
//    let heading: Int
    let id: String
}




