//
//  AccountView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
import URLImage

struct AccountDetails: View {
    @EnvironmentObject var auth: SessionStore
    var runService: RunsService = RunsService()
    @State var showingAlert = false
    @State var message = ""
    @State var title = ""
    var user: User
    @State var failedRun: NewRun?
    var api = ApiHost()
    
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
            
            Section(header: Text("Environment")) {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(Bundle.main.releaseVersionNumberPretty)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Bundle Version")
                    Spacer()
                    Text(Bundle.main.buildVersionNumber ?? "unknown")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("ENV")
                    Spacer()
                    Text(api.dev ? "PROD" : "LOCAL")
                        .foregroundColor(.secondary)
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

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
}

