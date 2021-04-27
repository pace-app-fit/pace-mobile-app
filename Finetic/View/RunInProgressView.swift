//
//  RunInProgressView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import SwiftUI

struct RunInProgressView: View {
    @ObservedObject var locationCoordinator = NewRunCoordinator()
    @ObservedObject var timer = StopWatchManager()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    Text(String(format: "%.2f", timer.secondsElapsed))
                        .font(.system(size: 84))
                        .bold()
                        .italic()
                        .foregroundColor(.white)
                    Text("Time")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Spacer()
                    VStack {
                        if timer.mode == .stopped {
                            Button(action: {
                                timer.start()
                                locationCoordinator.start()
                            }, label: {
                                Text("Start Run")
                            })
                            .modifier(ButtonModifier())
                            .frame(width: geo.size.width * 0.5)
                        } else if timer.mode == .running {
                            Button(action: {
                                timer.pause()
                            }, label: {
                                Text("Pause Run")
                            })
                            .modifier(ButtonModifier())
                            .frame(width: geo.size.width * 0.5)

                        } else {
                            VStack {
                                Spacer()
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                    timer.stop()
                                        locationCoordinator.stop()
                                }, label: {
                                    Text("Stop Run")
                                })
                                .modifier(ButtonModifier())
                                .frame(width: geo.size.width * 0.5)
                                
                                Spacer()
                                
                                Button(action: {
                                    timer.start()
                                }, label: {
                                    Text("Resume Run")
                                })
                                .modifier(ButtonModifier(backgroundColor: Color.blue))
                                .frame(width: geo.size.width * 0.5)

                                Spacer()
                            } .frame(height: geo.size.height * 0.3)
                            
                        }
                    }
                   
                    
                   
                    Spacer()
                }
                
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .scaledToFit()
                .background(Color.green)
                
            }
            .edgesIgnoringSafeArea(.all)
            
        }
       
       
        
        
        
    }
    
}

struct RunInProgressView_Previews: PreviewProvider {
    static var previews: some View {
        RunInProgressView()
    }
}
