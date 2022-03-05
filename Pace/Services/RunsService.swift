//
//  RunsService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-23.
//

import Foundation
import Alamofire

class RunsService: ApiHost, ObservableObject {
    @Published var myRuns = [Run]()
    @Published var feed = [Run]()
    var token = UserDefaults.standard.string(forKey: "token")
    var userId = UserDefaults.standard.string(forKey: "userId")

    func postRun(newRun: NewRun) {
        AF.request("\(host)/runs",
                   method: .post,
                   parameters: newRun,
                   encoder: JSONParameterEncoder.default,
                   headers: ["Authorization": "Bearer \(token!)"]
        ).responseDecodable(of: Run.self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(response.error)")
            }
            print(response)
        }
    }
    
    func getSelfRuns(){
        AF.request("\(host)/runs?userId=\(userId!)",
                   method: .get,
                   headers: ["Authorization": "Bearer \(token!)"]
        ).responseDecodable(of: [Run].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(response.error)")
            }
            self.myRuns = response.value ?? []
            print(response)
        }
    }
    
    func getFeed() {
        AF.request("\(host)/runs",
                   method: .get,
                   headers: ["Authorization": "Bearer \(token!)"]
        ).responseDecodable(of: [Run].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(response.error)")
            }
            self.feed = response.value ?? []
            print(response)
        }
    }
    


}

