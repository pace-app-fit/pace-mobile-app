//
//  FineticService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import Foundation
import Alamofire

class FineticService: ObservableObject {
    
    var query: String = "all"
    
    @Published var workouts: [Workout]?
    
    let root = "https://orange-lionfish-80.loca.lt"
    let token = UserDefaults.standard.string(forKey: "token")
    var headers: HTTPHeaders {
        get {
            [
                "Authorization": "Bearer \(token!)",
                "Accept": "application/json"
            ]
        }
    }
    
    func fetchAllWorkouts(query: String) {
        AF.request("\(root)/workouts/\(query)", headers: headers)
            .responseData { (res) in
                switch res.result {
                case .success(let data):
                    do {
                        self.workouts = try? JSONDecoder().decode([Workout].self, from: data)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    init() {
        fetchAllWorkouts(query: query)
    }
    
    
}
