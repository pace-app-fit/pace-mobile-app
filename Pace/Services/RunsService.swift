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
    @Published var loading = false
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
                print("AN error occores \(String(describing: response.error))")
            }
            print(response)
        }
    }
    
    func getSelfRuns(){
        loading = true
        AF.request("\(host)/runs?userId=\(userId!)",
                   method: .get,
                   headers: ["Authorization": "Bearer \(token!)"]
        ).responseDecodable(of: [Run].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            self.myRuns = response.value ?? []
            self.loading = false
        }
    }
    
    func getFeed() {
        loading = true
        AF.request("\(host)/runs",
                   method: .get,
                   headers: ["Authorization": "Bearer \(token!)"]
        ).responseDecodable(of: [Run].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            self.feed = response.value ?? []
            self.loading = false
        }
    }
    
    func deleteRun(runId: String, onSucess: @escaping (String) -> Void) {
        AF.request("\(host)/runs/\(runId)",
                   method: .delete,
                   headers: ["Authorization": "Bearer \(token!)"]
        ).response { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            onSucess("Successfully deleted run")
        }
    }
}

