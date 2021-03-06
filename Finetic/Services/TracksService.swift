//
//  TracksService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import Foundation
import Alamofire

class TracksService: ObservableObject {
    let root = "https://tasty-gecko-96.loca.lt"
    @Published var previousRuns: [Run]?
    
    func fetchTracks() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        
        
        
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
    
    init() {
        fetchTracks()
    }
}
