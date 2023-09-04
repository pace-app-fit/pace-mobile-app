//
//  Workout.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import Foundation

// MARK: - Workout
struct Workout: Codable, Identifiable, Hashable {
    var id, userId: String
    var name: String
    let user: MiniUser
    var videoUrl: String
    var difficulty, description: String
    var time: Int
    var thumbnail: String
    var createdAt, updatedAt: String
//    var equipment: String
}


