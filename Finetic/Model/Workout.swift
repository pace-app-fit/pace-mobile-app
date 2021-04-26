//
//  Workout.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import Foundation

// MARK: - Workout
struct Workout: Codable, Identifiable, Hashable {
    var id = UUID()
    var name, createdBy: String
    var videoURL: String
    var equipment, difficulty, time, workoutDescription: String
    var heroimg: String
    
    var heroURL: URL? {
        URL(string: heroimg)
    }
    

    enum CodingKeys: String, CodingKey {
        case name, createdBy
        case videoURL = "videoUrl"
        case equipment, difficulty, time
        case workoutDescription
        case heroimg = "heroURL"
    }
    
}


