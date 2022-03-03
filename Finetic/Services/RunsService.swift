//
//  RunsService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-23.
//

import Foundation
import Alamofire

class RunsService: ObservableObject {
    @Published var myRuns = [Run]()
    @Published var feed = [Run]()
    var token = UserDefaults.standard.string(forKey: "token")
    var userId = UserDefaults.standard.string(forKey: "userId")
    private var host = "http://3.96.220.190:3000"


    func postRun(newRun: NewRun) {
        AF.request("\(host)/api/v1/runs",
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
        AF.request("\(host)/api/v1/runs?userId=\(userId!)",
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
        AF.request("\(host)/api/v1/runs",
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

