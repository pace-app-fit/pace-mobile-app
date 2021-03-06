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
        ScrollView {
            Text("Hello \(session.user?.email ?? "unknown figure")")
        }
        
       
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
