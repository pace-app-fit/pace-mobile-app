//
//  RunsService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-23.
//

import Foundation
import Alamofire

struct ServerError: Codable, Error {
    var code: String
    var httpStatus: Int
    var message: String
}


class RunsService: ApiHost, ObservableObject {
    @Published var myRuns = [Run]()
    @Published var feed = [Run]()
    @Published var loading = false
    var token = UserDefaults.standard.string(forKey: "token")
    var userId = UserDefaults.standard.string(forKey: "userId")
    
//    func postRun(newRun: NewRun, completion: @escaping (Result<Run, ServerError>) -> Void) {
//            let Url = String(format: "\(host)/runs")
//           guard let serviceUrl = URL(string: Url) else { return }
//        guard let body = try? JSONEncoder().encode(newRun) else {return}
//           var request = URLRequest(url: serviceUrl)
//           request.httpMethod = "POST"
//           request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//
//           request.httpBody = body
//
//           let session = URLSession.shared
//           session.dataTask(with: request) { (data, response, error) in
//
//               if let error = error {
//                   print("There's an error")
//                   print(error)
//               }
//
//
//
//           }.resume()
//    }

    func postRun(newRun: NewRun, completion: @escaping (Result<Run, ServerError>) -> Void) {
        AF.request("\(host)/runs",
                   method: .post,
                   parameters: newRun,
                   encoder: JSONParameterEncoder.default,
                   headers: ["Authorization": "Bearer \(token!)"]
        )
            .responseData { response in
                let decoder = JSONDecoder()
                
                guard let status = response.response?.statusCode else {
                    let unknownError = ServerError(code: "UNKNOWN ERROR", httpStatus: 500, message: "Sorry the server is unavilable right now please try and upload your run later")
                    return completion(Result.failure(unknownError))
                }

                do {
                    if(status >= 400) {
                        do {
                            let apiError = try decoder.decode(ServerError.self, from: response.data!)
                            completion(Result.failure(apiError))
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        let run = try decoder.decode(Run.self, from: response.data!)
                        completion(Result.success(run))
                    }
                } catch {
                    print("ERROR IN CATCH")
                    print(error)
                    let unknownError = ServerError(code: "UNKNOWN ERROR", httpStatus: 500, message: error.localizedDescription)
                    completion(Result.failure(unknownError))
                }
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

