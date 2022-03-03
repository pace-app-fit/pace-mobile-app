//
//  RunInProgressView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import SwiftUI
import MediaPlayer
import MapKit

struct RunInProgressView: View {
    var trackName = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.title
    var trackArtist = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.artist
    
    @ObservedObject var locationCoordinator = NewRunCoordinator()
    @ObservedObject var timer = StopWatchManager()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var defaultRegion = MKCoordinateRegion(
        // Apple Park
        center: CLLocationCoordinate2D(latitude: 51, longitude: -114.1161533106428),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var localTimer: String {
        timer.printSecondsToHoursMinutesSeconds(seconds: Int(timer.secondsElapsed))
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    NewRunMapView(region: locationCoordinator.region ?? defaultRegion, lineCoordinates: locationCoordinator.lineCoordinates)
                        .frame(height: 400)
                    Spacer()
                    Text(localTimer)
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
