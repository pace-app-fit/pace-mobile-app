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
                    Label("Home", systemImage: "house")
                }
           RunsView()
                .tabItem {
                    Label("Social", systemImage: "list.bullet")
                }
            NewTrackView()
                .tabItem {
                    Label("New", systemImage: "plus.circle.fill")
                }
            Finetic()
                .tabItem {
                    Label("Pace", systemImage: "bolt")
                }
            AccountView()
                .tabItem {
                    Label("Me", systemImage: "person")
                }
        }
    }
}
