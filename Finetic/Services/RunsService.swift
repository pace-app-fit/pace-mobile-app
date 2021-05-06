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
import FirebaseFirestoreSwift
import Combine

enum UploadError: Error {
    case uploadFailed, decodeFailed
}

class RunsService: SessionStore {
    var firestore = Firestore.firestore()
    @Published var myRuns = [Run]()
    @Published var socialRuns = [Run]()

    var requests = Set<AnyCancellable>()
    private var trackInformationUrl = URL(string: "https://us-central1-finetic-36645.cloudfunctions.net/getTrackInformation")!
    
    func upload<Input: Encodable, Output: Decodable>(_ data: Input, to url: URL, httpMethod: String = "Post", contentType: String = "application/json", completion: @escaping (Result<Output, UploadError>) -> Void) -> Void {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
//            .map(\.data)
            .map { a in
                print(String(decoding: a.data, as: UTF8.self))
                return a.data
            }
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
                    
                    self.firestore.collection("runs").document(run.createdBy).collection("runs").document(run.id).setData(encodedRun)

                } catch let err {
                    print(err)
                }

            case .failure(let err):
                print(err)
            }

        }

    }
    
    func deleteRun(run: Run, onSuccess: @escaping(_ message: String) -> Void) {
        let currentUser = Auth.auth().currentUser?.uid
        firestore.collection("runs").document(currentUser!).collection("runs").document(run.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                onSuccess("Successfully deleted run")
            }

        }
    }

    func fetchRuns(userId: String, onSuccess: @escaping(_ runs: [Run]) -> Void) {
        firestore.collection("runs").document(userId).collection("runs").getDocuments {(querySnapshot, err) in
            guard let allRuns = querySnapshot?.documents else {return print("Error")}
            
            var runs = [Run]()
            runs = allRuns.compactMap { run in
                try? run.data(as: Run.self)
            }
            onSuccess(runs)
            
            
        }
        
    }
    
    func fetchRunsfromFriends() {
        firestore.collection("runs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                return print(err.localizedDescription)
            }
            
            guard let allRuns = querySnapshot?.documents else {return print("Couldnt load runs")}
            
            self.socialRuns = allRuns.compactMap { run in
                try? run.data(as: Run.self)
                
            }
            
        }
    }
    
    func getLifeTimekm(_ uid: String) -> Double{
        let lifeTimeKm: Double
        
        lifeTimeKm = self.myRuns.map{ $0.distance }.reduce(0, +)
        return lifeTimeKm
    }
    
    override init() {
        super.init()
        
        fetchRunsfromFriends()
    }
}


//
//    func uploadData(run: NewRun) -> Run? {
//        var request = URLRequest(url: trackInformationUrl)
//        request.httpMethod = "Post"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let encoder = JSONEncoder()
//        request.httpBody = try? encoder.encode(run)
//
//        var run: Run?
//
//        URLSession.shared.dataTask(with: request) {data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//
//                    do {
//                        let decodedResponse = try JSONDecoder().decode(Run.self, from: data)
//                        run = decodedResponse
//
//                    }
//                    catch let jsonError as NSError {
//                        print("JSON decode failed: \(jsonError.localizedDescription)")
//                      } catch DecodingError.keyNotFound(let key, let context) {
//                        Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
//                    } catch DecodingError.valueNotFound(let type, let context) {
//                        Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
//                    } catch DecodingError.typeMismatch(let type, let context) {
//                        Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
//                    } catch DecodingError.dataCorrupted(let context) {
//                        Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
//                    } catch let error as NSError {
//                        NSLog("Error in read(from:ofType:) domain= \(error), description= \(error.localizedDescription)")
//                    }
//
//                }
//
//            }
//
//        }.resume()
//        return run
//
//
//    }
//
//    func postRun(newRun: NewRun) {
//        let run = uploadData(run: newRun)
//        print("------ \(run) -----")
//        guard let encodedRun = try?run.asDictionary() else {return}
//
//        do {
//            self.firestoreID.collection("runs").document(newRun.id.uuidString).setData(encodedRun)
//
//        } catch let err {
//            print(err)
//        }
//    }
