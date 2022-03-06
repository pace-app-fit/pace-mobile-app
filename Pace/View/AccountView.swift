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
            ScrollView {
                Group {
                    if(tracks.loading) {
                        ProgressView()
                            .padding(.top, 200)
                    } else {
                        if(tracks.myRuns.count < 1) {
                            VStack {
                                Text("No runs yet...")
                                    .foregroundColor(.secondary)
                                    .font(.title)
                                    .bold()
                                Text("Why not go for a run")
                                    .foregroundColor(.secondary)
                                   
                            }
                            .frame(width: 340, height: 200)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                            .padding(.top, 200)
                        } else {
                            ForEach(tracks.myRuns, id: \.self) { track in
                                RunCard(track: track)
                   
                            }
                        }
                    }
                }
            }
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
    var runService: RunsService = RunsService()
    @State var showingAlert = false
    @State var message = ""
    @State var title = ""
    var user: User
    @State var failedRun: NewRun?
    
    func getUploadError() {
        if let data = UserDefaults.standard.data(forKey: "run") {
            do {
                let decoder = JSONDecoder()

                let run = try decoder.decode(NewRun.self, from: data)
                self.failedRun = run

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    func deleteFailedRun() {
        UserDefaults.standard.removeObject(forKey: "run")
        self.failedRun = nil
    }
    
    var body: some View {
        Form {
            Section() {
                HStack{
                    URLImage(url: URL(string: user.profileImage)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .cornerRadius(50)
                    }
                    VStack(alignment: .leading) {
                        Text(user.userName)
                            .font(.headline)
                        Text(user.email)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }

                }
            }
        
            Section(header: Text("Upload errors")) {
                HStack{
                    Text(failedRun?.name ?? "All runs uploaded" )
                        .font(.headline)
                    Spacer()
                    if(failedRun?.name != nil) {
                        if(runService.loading) {
                            ProgressView()
                        } else {
                            Image(systemName: "icloud.and.arrow.up")
                                .onTapGesture {
                                    runService.postRun(newRun: failedRun!) { res in
                                        switch res {
                                        case .success(_):
                                            self.title = "Success"
                                            self.message = "Your run has been uploaded"
                                            self.showingAlert = true
                                            deleteFailedRun()
                                        case .failure(let err):
                                            self.title = "Error"
                                            self.message = err.message
                                            self.showingAlert = true
                                            
                                        }
                                    }
                                }
                        }
                        }
                }
            }
              
            
            Section {
                Button(action: {
                    auth.logout()
                }) {
                    Text("Signout")
                        .foregroundColor(Color.red)
                }
            }
            
           
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("Ok")))
        }
        .onAppear{
            getUploadError()
        }
    }
       
    
}

