//
//  SocialService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-05-02.
//

import Foundation
import FirebaseFirestore
import Alamofire

class SocialService: ApiHost, ObservableObject {
    @Published var following = 0
    @Published var followers = 0
    @Published var runs: [Run] = []
    @Published var user: User?
    @Published var loading = false
    @Published var users: [User] = []
    @Published var stat: UserStat?
    
    func getUser(userId: String) {
        loading = true
        AF.request("\(host)/users/\(userId)",
                   method: .get
        ).responseDecodable(of: User.self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            self.user = response.value!
            self.loading = false
        }
    }
    
    func getUserRuns(userId: String){
        loading = true
        AF.request("\(host)/runs?userId=\(userId)",
                   method: .get
        ).responseDecodable(of: [Run].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            self.runs = response.value ?? []
            self.loading = false
        }
    }
    
    func getAllUsers() {
        loading = true
        AF.request("\(host)/users",
                   method: .get
        ).responseDecodable(of: [User].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            self.users = response.value ?? []
            self.loading = false
        }
    }
    
    func searchUsers(searchText: String) {
        loading = true
        AF.request("\(host)/users?query=\(searchText)",
                   method: .get
        ).responseDecodable(of: [User].self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            self.users = response.value ?? []
            self.loading = false
        }
    }
    
    func getUserStats(userId: String) {
        AF.request("\(host)/stats?userId=\(userId)",
                   method: .get
        ).responseDecodable(of: UserStat.self) { (response) in
            if(response.error != nil) {
                print("AN error occores \(String(describing: response.error))")
            }
            
            print(response)
            
            if let stat = response.value {
                self.stat = stat
            }
          
        }
    }
    
    static var following = Firestore.firestore().collection("following")
    
    static var followers = Firestore.firestore().collection("followers")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("following")
    }
    
    static func followersCollection(userId: String) -> CollectionReference {
        return followers.document(userId).collection("followers")
    }
    
    func follows(userId: String) {
        SocialService.followingCollection(userId: userId).getDocuments { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else {return}
            
            self.following = documents.count
        }
    }

    func followedBy(userId: String) {
        SocialService.followersCollection(userId: userId).getDocuments { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else {return}
            
            self.followers = documents.count
        }
    }
    
    
    func loadUserRuns(userId: String) {
//        RunsService().fetchRuns(userId: userId) { runs in
//            self.runs = runs
//        }
    }
    
   
}
