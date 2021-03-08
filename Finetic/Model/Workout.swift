//
//  Workout.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import Foundation

// MARK: - Workout
struct Workout: Codable, Identifiable, Hashable {
    var id, name, createdBy: String
    var videoURL: String
    var equipment, difficulty, time, workoutDescription: String
    var heroimg: String
    var v: Int
    
    var heroURL: URL? {
        URL(string: heroimg)
    }
    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdBy
        case videoURL = "videoUrl"
        case equipment, difficulty, time
        case workoutDescription = "description"
        case heroimg
        case v = "__v"
    }
    
}


