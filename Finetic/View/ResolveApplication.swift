//
//  ResolveApplication.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import SwiftUI

struct ResolveApplication: View {
    
    @StateObject var session = SessionStore()
    
    var body: some View {
        Group {
            if (session.isAuthorized) {
                AppView()
            } else {
                SigninView()
            }
        }.environmentObject(session)
        
    }
    
    
}


