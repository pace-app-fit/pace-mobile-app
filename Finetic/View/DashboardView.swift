//
//  DashboardView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        NavigationView {
            ScrollView {
                
            }
            .navigationTitle("\(session.user?.firstName.capitalized ?? "Dashboard")")
        }
       
        
       
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
