import Foundation

// MARK: - WelcomeElement
struct Run: Codable, Hashable {
    let name, id: String
    let locations: [Location]
    let userID: String
    let time, distance, averagePace, averageSpeed: Double
    let v: Int
    let createdAt: String
    let timestamp: String?

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




