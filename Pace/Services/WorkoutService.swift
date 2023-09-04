//
//  WorkoutService.swift
//  Pace
//
//  Created by Tapiwa Kundishora on 2022-03-23.
//

import Foundation
import Alamofire

class WorkoutService: ApiHost, ObservableObject {
    @Published var workouts: [Workout] = []
    
    func getWorkouts() {
        AF.request("\(host)/workouts",
                   method: .get).responseDecodable(of: [Workout].self) { response in
            if(response.error != nil) {
                let responseData = String(data: response.data!, encoding: String.Encoding.utf8)
                print("An error occured \(String(describing: response.error))")
            }
            
            if let workouts = response.value {
                print(workouts)
                self.workouts = workouts
            }
        }
    }
}
