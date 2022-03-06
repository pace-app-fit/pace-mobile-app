//
//  NewTrackView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct NewTrackView: View {
    @State var failedRun: NewRun?
    @State var showingAlert = false
    @State var showingUploadAlert = false

    @State var message = ""
    @State var title = ""
    var runService: RunsService = RunsService()

    func getUploadError() {
        if let data = UserDefaults.standard.data(forKey: "run") {
            do {
                let decoder = JSONDecoder()

                let run = try decoder.decode(NewRun.self, from: data)
                self.failedRun = run
                print(run)

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    func deleteFailedRun() {
        UserDefaults.standard.removeObject(forKey: "run")
        self.failedRun = nil
    }
    
    @State private var isPresented = false
    var body: some View {
        GeometryReader { geo in
            
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button("Start run") {
                    if(failedRun?.name != nil) {
                        self.title = "A previous run didn't upload"
                        self.message = "We detected a run that failed to upload. Do you want to upload it now or delete it"
                        self.showingAlert = true
                    }
                    isPresented.toggle()
                }
                .modifier(ButtonModifier())
                .frame(width: geo.size.width * 0.5)
                Spacer()
            }
               
            Spacer()
            }
            
        }.onAppear(perform: getUploadError)
        .fullScreenCover(isPresented: $isPresented, content: RunInProgressView.init)
        .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteFailedRun()
                        isPresented.toggle()
                    },
                    secondaryButton: .cancel(Text("Upload")) {
                        runService.postRun(newRun: failedRun!) { res in
                            switch res {
                            case .success(_):
                                self.title = "Great"
                                self.message = "Succesfully uploaded run"
                                self.showingUploadAlert = true
                                isPresented.toggle()
                                deleteFailedRun()
                            case .failure(let err):
                                self.title = "Error uploading"
                                self.message = err.message
                                self.showingAlert = true
                                
                            }
                        }

                    }
                    )
        }
            
    }
}

struct NewTrackView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrackView()
    }
}
