//
//  SessionViewModel.swift
//  Finetic
//
//  Created by Tapiwa Kundishora on 2022-02-28.
//

import Foundation
import Combine


class ApiHost {
    var dev = true
    
    var host: String {
        get {
            return dev ? "http://192.168.1.199:4343/api/v1" : "http:192.168.1.83:3000/api/v1"
        }
    }
}
