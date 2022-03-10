//
//  RunDetailsView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-25.
//

import SwiftUI

struct RunDetailsView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var runs = RunsService()
    @EnvironmentObject var auth: SessionStore

    @State private var isShowingAlert = false
    @State private var alertMsg = ""
    
    var track: Run
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.purple)                
                HStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("Distance")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Text(track.formatedDistance)
                            .font(.largeTitle)
                            .italic()
                            .bold()
                            
                    }.padding(.bottom, 0)
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Time")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Text(track.formatedTime)
                            .font(.largeTitle)
                            .italic()
                            .bold()
                            
                    }.padding(.bottom, 0)
                }
                
               
                HStack {
                    if (track.weather != nil) {
                        RunStatComponent(label: "Temp", value: track.formatedTemperature)
                        Divider()
                    }
                    RunStatComponent(label: "Elevation", value: track.totalElevation.totalElevationAsString)
                    Divider()
                    RunStatComponent(label: "Pace", value: track.formatedPace)
                }
                .padding(.top, 0)
                MapView(track: track, allowInteraction: true)
                    .frame(height: 270)
                    .cornerRadius(15)
//                Text("Splits")
//                    .font(.title)
//                    .padding(.vertical)
//                SplitsTableComponent(data: track.unitAnalysis)
                
                
            }
            
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Done"), message: Text(alertMsg))
        }
        .padding(.horizontal)
        .navigationTitle("Analysis")
        .navigationBarItems(trailing: track.userId == auth.user?.id ? Button(action: {
            runs.deleteRun(runId: track.id) { res in
                print(res)
                self.alertMsg = res
                self.isShowingAlert = true
                self.presentation.wrappedValue.dismiss()
            }
        }, label: {
            Text("Delete")
                .foregroundColor(Color.red)
        }) : nil)
       
        
    }
}

