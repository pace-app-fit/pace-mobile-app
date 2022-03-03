//
//  SocialService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-05-02.
//

import Foundation
import FirebaseFirestore

class SocialService: ObservableObject {
    @Published var following = 0
    @Published var followers = 0
    @Published var runs: [Run] = []
    
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
