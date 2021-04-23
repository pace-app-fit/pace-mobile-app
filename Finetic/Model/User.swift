//
//  User.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation

struct User: Encodable, Decodable {
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    
}
