//
//  User.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation

struct Session: Codable {
    var token: String
    var user: User
}

struct User: Codable, Hashable {
    var id: String
    var email: String
    var name: String
    var userName: String
    var profileImage: String

}

struct NewUser: Codable, Hashable {
    var name: String
    var userName: String
    var password: String
    var email: String
}

struct MiniUser: Codable, Hashable, Equatable {
    let userName: String
    let profileImage: String
    let id: String
}

struct LoginUser: Encodable {
    var email: String
    var password: String
}

struct UserStat: Codable {
    let currentYear: UserStatData
}

struct UserStatData: Codable {
    let distance: Double
    
    var roundedDistance: String {
        let round = round(distance * 10) / 10
        return String(round)
    }
}
