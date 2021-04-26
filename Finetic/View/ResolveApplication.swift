//
//  ResolveApplication.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import SwiftUI

struct ResolveApplication: View {
    @EnvironmentObject var session: SessionStore
    
    @ViewBuilder var logged: some View {
        if session.isSignedIn {
            AppView()
        } else {
            SignupView()
        }
    }
    
    var body: some View {
        VStack {
            logged
        }
        
    }
    
    
}


