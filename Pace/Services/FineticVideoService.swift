//
//  FineticVideoService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class FineticVideoService: ObservableObject {
    @Published var workouts: [Workout]? = []
    var storeRoot = Firestore.firestore()
    
    func fetchWorkouts(filterBy: String){
        storeRoot.collection("workouts").getDocuments() {(data, err) in
            if let err = err {
                print("Error getting documents: \(err.localizedDescription)")
               } else {
                for document in data!.documents {
                    guard let decodedWorkout = try? Workout?.init(fromDictionary: document.data()) else {return}
                    self.workouts?.append(decodedWorkout)
                   }
               }
        }
        
        
        
    }
    
    init() {
        fetchWorkouts(filterBy: "all")
    }
}
