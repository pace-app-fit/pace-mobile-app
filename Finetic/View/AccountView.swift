//
//  AccountView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var session: SessionStore
    @State var isShowingAccountDetails = false
    @ObservedObject var tracks = RunsService()
    @ObservedObject var social = SocialService()
    
    var body: some View {
       
        ScrollView(showsIndicators: false) {
                    AccountHeader(tracks: tracks)
                    Text("This Week")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    PersonalWeeklyCard()
                        .frame(height: 150)
                        .padding(.horizontal)
                    Text("Previous runs")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    Spacer()
            VStack{
              
                ForEach(social.runs, id: \.id) { track in
                        RunCard(track: track)
                        }
                
              
            }
            .onAppear {
                social.loadUserRuns(userId: (session.session?.uid)!)
            }

            
    }
        .navigationBarHidden(true)
        .navigationBarItems(trailing: Button(action: {
            isShowingAccountDetails = true
        }, label: {Text("Details")}))
        .sheet(isPresented: $isShowingAccountDetails) {
            AccountDetails(session: session)
        }
        
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct AccountHeader: View {
    var tracks =  RunsService()
    var session = SessionStore()
    
    func getLifeTimeKm() -> String {
        let distance = tracks.getLifeTimekm((session.currentUser?.uid)!)
        return String(format: "%.2f", distance)
    }
    
    var body: some View {
            HStack(alignment: .center) {
                Spacer()
                VStack {
                    Text("27")
                    Text("Coins")
                }
                Spacer()
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 100)
                    Text("Angela Valdez")
                        .bold()
                }
                Spacer()
                VStack {
                    Text("598")
                    Text("Followers")
                }
                Spacer()
                
        }
    }
}


struct AccountDetails: View {
    var session: SessionStore
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                HStack{
                    Text(session.session?.firstName ?? "Log in")
                        .font(.headline)
                    Spacer()
                        
                }
                HStack{
                    Text(session.session?.email ?? "Log in")
                        .font(.headline)
                    Spacer()
                        
                }
                    
            }
            
            Section(header: Text("Log out")) {
                Text("Signout")
                    .onTapGesture(perform: session.logout)
            }
        }
    }
}
}
