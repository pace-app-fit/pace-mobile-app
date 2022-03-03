//
//  AppView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        VStack {
            CustomTabView()

        }
    }
}

struct CustomTabView: View {
    @State var selectedTab = "plus.circle.fill"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets

    var tabs = ["house", "list.bullet", "plus.circle.fill", "bolt", "person"]

    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $selectedTab) {
                    DashboardView()
                        .tag("house")
    //                    .tabItem {
    //                        Image(systemName: "house")
    //                        Text("Dashboard")
    //                    }
                   RunsView()
                    .tag("list.bullet")
    //                .tabItem {
    //                    Image(systemName: "list.bullet")
    //                    Text("Previous Runs")
    //                }
                    NewTrackView()
                        .tag("plus.circle.fill")
    //                    .tabItem {
    //                        Image(systemName: "plus.circle.fill")
    //                        Text("New run")
    //                    }
                    Finetic()
                        .tag("bolt")
    //                    .tabItem {
    //                        Image(systemName: "bolt")
    //                        Text("Finetic")
    //                    }
                    AccountView()
                        .tag("person")
    //                    .tabItem {
    //                        Image(systemName: "person")
    //                        Text("Account")
    //                    }
                    
                }
               
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                    
                }
            }.padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
            .padding(.bottom, edge!.bottom == 0 ? 20 : 0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all))

        }

    
}

struct TabButton: View {
    var image: String
    
    @Binding var selectedTab:String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color.pink : Color.black)
                .padding()
        }
    }
}
