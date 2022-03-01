//
//  Request.swift
//  Finetic
//
//  Created by Tapiwa Kundishora on 2022-03-01.
//

import Foundation
import Combine

enum UploadError: Error {
    case uploadFailed, decodeFailed
}

enum NetworkError: Error {
    case badUrl
    case noData
    case request(underlyingError: Error)
    case unableToDecode(underlyingError: Error)
}

class ApiService {
    var token = UserDefaults.standard.string(forKey: "token")
    var requests = Set<AnyCancellable>()
    var devToken =   "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNsMDdhOHZjNDAyNjVmOHZhdWRpNHJkd24iLCJpYXQiOjE2NDYwODg5NTl9.DwWLjg2NXOTTVwM25kOQ1yk7Ufn2qhh_UPnLA-HDf_c"
    var host = "http://localhost:3000/api/v1"

    func post<Input: Encodable, Output: Decodable>(_ data: Input,  endpoint: String, httpMethod: String = "Post", contentType: String = "application/json", completion: @escaping (Result<Output, UploadError>) -> Void) -> Void {
        let url = URL(string: host+endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(token ?? devToken)", forHTTPHeaderField: "Authorization")

        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        let str = String(decoding: request.httpBody!, as: UTF8.self)
        print("BODY \(str)")

        URLSession.shared.dataTaskPublisher(for: request)
            .mapError{
                NetworkError.request(underlyingError: $0)
                
            }
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
}
