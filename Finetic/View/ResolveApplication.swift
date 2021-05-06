//
//  ResolveApplication.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-04.
//

import SwiftUI

struct ResolveApplication: View {
    @EnvironmentObject var session: SessionStore
    
    
     var body: some View {
        Group {
            if session.session != nil {
                AppView()
            } else {
                SignupView()
            }
        }.onAppear(perform: session.listen)
        
    }
    
}


