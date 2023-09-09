import Foundation
import MapKit

// MARK: - WelcomeElement
struct Run: Decodable, Hashable, Equatable {
    let id: Int
    let name, createdAt: String
    let coordinates: [Coordinate]
    let distance, averagePace, averageSpeed: Double
    let time: Int
    let totalElevation: TotalElevation
    let weather: WeatherDetails?
    
    let user: MiniUser
    
   
    
//    enum CodingKeys: String, CodingKey {
//        case name, id, userId, createdAt, coordinates, time, distance, averagePace, averageSpeed, totalElevation, weather, user
//    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.weather = try values.decode(WeatherDetails?.self, forKey: .weather)
//        self.name = try values.decode(String.self, forKey: .name)
//        self.id = try values.decode(String.self, forKey: .id)
//        self.userId = try values.decode(String.self, forKey: .userId)
//        self.createdAt = try values.decode(String.self, forKey: .createdAt)
//        self.coordinates = try values.decode([Coordinate].self, forKey: .coordinates)
//        self.time = try values.decode(Double.self, forKey: .time)
//        self.distance = try values.decode(Double.self, forKey: .distance)
//        self.averagePace = try values.decode(Double.self, forKey: .averagePace)
//        self.averageSpeed = try values.decode(Double.self, forKey: .averageSpeed)
//        self.totalElevation = try values.decode(TotalElevation.self, forKey: .totalElevation)
//        self.user = try values.decode(MiniUser.self, forKey: .user)
//    }

    
    var formatedTime: String {
        let totalSeconds = Int(time)
        let minutes = String((totalSeconds % 3600) / 60)
        let seconds = String((totalSeconds % 3600) % 60)
        return String("\(minutes):\(seconds)")
    }
    
    var formatedDistance: String {
       "\(String(format: "%.2f", distance))km"
    }
    
    var formatedTemperature: String {
        let temp = Int(weather?.feelsLike ?? 0)
        return (String("\(temp)°"))
    }
    
    var formatedPace: String {
        let minutes = averagePace.rounded(.down)
        let wholeMinutes = String(format: "%g", minutes)
        let seconds = ((averagePace-minutes)*60).rounded(.up)
        let wholeSeconds = String(format: "%g", seconds)
        return String("\(wholeMinutes)'\(wholeSeconds)\"")
    }
    
    var formatedCreatedDate: String {
        let df1 = DateFormatter()
        df1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = df1.date(from: createdAt)
        let df2 = DateFormatter()
        df2.dateFormat = "EEEE MMM d, yyyy"
        return df2.string(from: date!)
    }
    
    var formatedSpeed: String {
        let speed = String(format: "%.2f", averageSpeed)
        return "\(speed)km/h"
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




