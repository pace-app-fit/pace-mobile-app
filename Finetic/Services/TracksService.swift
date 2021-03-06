//
//  TracksService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation
import Alamofire

class TracksService: ObservableObject {
    let root = "https://orange-lionfish-80.loca.lt"
    @Published var previousRuns: [Run]?
    let token = UserDefaults.standard.string(forKey: "token")
    var headers: HTTPHeaders {
        get {
            [
                "Authorization": "Bearer \(token!)",
                "Accept": "application/json"
            ]
        }
       
    }
    
    func fetchTracks() {
        AF.request("\(root)/tracks", headers: headers)
            .responseData { (res) in
                switch res.result {
                case .success(let data):
                    do {
                        self.previousRuns = try? JSONDecoder().decode([Run].self, from: data)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
    
    func postTracks(run: NewRun) {
        
        guard let encodedRun = try? JSONEncoder().encode(run) else {return}
        
        guard let parameters = try? JSONSerialization.jsonObject(with: encodedRun, options: []) as? [String: Any] else {
            return
        }
        
        
        AF.request("\(root)/tracks", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (res) in
                let body = res.value as! NSDictionary
                let token = body["token"] as! String
               
                
            }
        
   
       

    }
    
 
    
    init() {
        fetchTracks()
    }
}
