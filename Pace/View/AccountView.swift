//
//  AccountView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
import URLImage

struct AccountView: View {
    @EnvironmentObject var auth: SessionStore
    @State var isShowingAccountDetails = false
    @ObservedObject var tracks = RunsService()
    @ObservedObject var social = SocialService()
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(tracks.myRuns, id: \.self) { track in
                        RunCard(track: track)
                            .listRowInsets(EdgeInsets())
           
                    }
                }
            }
            .padding(.top, 100)
            .onAppear {
                tracks.getSelfRuns()
            }
            .navigationTitle("My runs")

            .navigationBarItems(trailing: Button(action: {
                isShowingAccountDetails = true
            }, label: {Text("Details")}))
            .sheet(isPresented: $isShowingAccountDetails) {
                AccountDetails(user: auth.user!)
            }

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
        
        
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct AccountHeader: View {
    var user: User
//    func getLifeTimeKm() -> String {
//        let distance = tracks.getLifeTimekm((session.currentUser?.uid)!)
//        return String(format: "%.2f", distance)
//    }
    
    var body: some View {
            HStack(alignment: .center) {
                Spacer()
                VStack {
                    Text("0")
                    Text("Followers")
                }
                Spacer()
               
                VStack {
                    URLImage(url: URL(string: user.profileImage)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(15)
                    }
                    Text(user.userName)
                        .bold()
                }
                Spacer()
                VStack {
                    Text("0")
                    Text("Followers")
                }
                Spacer()
                
        }
    }
}


struct AccountDetails: View {
    @EnvironmentObject var auth: SessionStore
    var user: User
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                HStack{
                    Text(user.userName )
                        .font(.headline)
                    Spacer()
                        
                }
                HStack{
                    Text(user.email )
                        .font(.headline)
                    Spacer()
                        
                }
                    
            }
            
            Section(header: Text("Log out")) {
                Text("Signout")
                    .onTapGesture(perform: auth.logout)
            }
        }
    }
}

