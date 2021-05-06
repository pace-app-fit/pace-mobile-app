//
//  RunDetailsView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-25.
//

import SwiftUI

struct RunDetailsView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var firestore = RunsService()
    
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
                        Text("Speed")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Text(track.formatedSpeed)
                            .font(.largeTitle)
                            .italic()
                            .bold()
                            
                    }.padding(.bottom, 0)
                }
                
               
                HStack {
                    RunStatComponent(label: "Elevation", value: track.totalElevation.totalElevationAsString)
                    Divider()
                    RunStatComponent(label: "Pace", value: track.formatedPace)
                    Divider()
                    RunStatComponent(label: "Time", value: track.formatedTime)
                }
                .padding(.top, 0)
                MapView(track: track)
                    .frame(height: 270)
                Text("Splits")
                    .font(.title)
                    .padding(.vertical)
                SplitsTableComponent(data: track.unitAnalysis)
                
                
            }
            
        }
        .padding(.horizontal)
        .navigationTitle("Analysis")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    presentation.wrappedValue.dismiss()
                                }, trailing: Text("Delete")
                                    .onTapGesture {
                                        firestore.deleteRun(run: track) { msg in
                                            alertMsg = msg
                                            isShowingAlert = true
                                        }
                                    }
        )
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("All done"), message: Text(alertMsg))
        }
        
    }
}

