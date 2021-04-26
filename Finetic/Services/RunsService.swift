//
//  RunsService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine

enum UploadError: Error {
    case uploadFailed, decodeFailed
}

class RunsService: SessionStore {
    @Published var runs: [Run]? = []
    var requests = Set<AnyCancellable>()
//    private var trackInformationUrl: URL = URL(string: "https://us-central1-finetic-36645.cloudfunctions.net/getTrackInformation")!
    private var trackInformationUrl = URL(string: "https://us-central1-finetic-36645.cloudfunctions.net/getTrackInformation")!
    
    func upload<Input: Encodable, Output: Decodable>(_ data: Input, to url: URL, httpMethod: String = "Post", contentType: String = "application/json", completion: @escaping (Result<Output, UploadError>) -> Void) -> Void {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .map(\.data)
            .decode(type: Output.self, decoder: JSONDecoder())
            .map(Result.success)
            .catch {error -> Just<Result<Output, UploadError>> in
                error is DecodingError
                    ? Just(.failure(.decodeFailed))
                    : Just(.failure(.uploadFailed))
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
        
    }
    
    func postRun(newRun: NewRun) {
        self.upload(newRun, to: trackInformationUrl) {(result: Result<Run, UploadError>) in
            print(result)
            switch result {
            case .success(let run):
                guard let encodedRun = try?run.asDictionary() else {return}

                do {
                    self.firestoreID.collection("runs").document(newRun.id.uuidString).setData(encodedRun)

                } catch let err {
                    print(err)
                }

            case .failure(let err):
                print(err)
            }
            
        }
        
    }
    
    func fetchRuns() {
        firestoreID.collection("runs").getDocuments() { (data, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                for run in data!.documents {
                    guard let decodedRun = try? Run.init(fromDictionary: run.data()) else {return}
                    self.runs?.append(decodedRun)
                }
            }
        }
    }
    
    override init() {
        super.init()
        fetchRuns()
    }
}
