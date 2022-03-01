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
    @Published var socialRuns = [Run]()
    var token = UserDefaults.standard.string(forKey: "token")
   

    func postRun(newRun: NewRun) {
        AF.request("http://localhost:3000/api/v1/runs",
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
    


}

