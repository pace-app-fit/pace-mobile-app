//
//  CreateRunHelperFunctions.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-25.
//

import Foundation

struct CreateRunHelperFunctions {
    
    
    func createName() -> String {
      let hour = Calendar.current.component(.hour, from: Date())
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayInWeek = dateFormatter.string(from: date)
      
      let NEW_DAY = 0
      let NOON = 12
      let SUNSET = 17
      let NIGHT = 19
      let MIDNIGHT = 24
      
      var timeOfDay = "" // Default greeting text
      switch hour {
      case NEW_DAY..<NOON:
          timeOfDay = "Morning"
      case NOON..<SUNSET:
          timeOfDay = "Afternoon"
      case SUNSET..<NIGHT:
          timeOfDay = "Evening"
      case NIGHT..<MIDNIGHT:
        timeOfDay = "Night"
      default:
          timeOfDay = ""
      }
      
      return "\(dayInWeek) \(timeOfDay) Run"
    }
}
