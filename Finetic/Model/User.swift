//
//  User.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation

struct User {
    var email: String
    var token: String
    var firstName: String
    var lastName: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
}
