//
//  SearchService.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SearchService: ObservableObject {
    var db = Firestore.firestore()
    @Published var name = ""
    func searchUser(input: String, onSucess: @escaping (_ user: [User]) -> Void) {
        Firestore.firestore().collection("users").whereField("searchName", arrayContains: input.lowercased().removeWhiteSpaces()).getDocuments { (querySnapshot, err) in
             
        }
    }


    func searchUserById(_ uid: String) {
       
    }
    
    init(_ uid: String) {
        searchUserById(uid)
        print(self.name)
    }
    
   
    
}
