//
//  AppView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct AppView: View {
    

    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
           RunsView()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Previous Runs")
            }
            NewTrackView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("New run")
                }
            Finetic()
                .tabItem {
                    Image(systemName: "bolt")
                    Text("Finetic")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
