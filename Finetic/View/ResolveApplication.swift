//
//  ResolveApplication.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import SwiftUI

struct ResolveApplication: View {
    @StateObject var auth: SessionStore = SessionStore()
    
     var body: some View {
        Group {
            if auth.isSignedIn == nil {
                EmptyView()
            } else {
                if(auth.isSignedIn!) {
                    AppView()
                        .environmentObject(self.auth)
                } else {
                    SignupView()
                         .environmentObject(self.auth)
                }
            }
        }.onAppear(perform: localSignin)
        
    }
    
    func localSignin() {
        auth.localSignin()
    }
    
}


