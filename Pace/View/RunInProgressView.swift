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
    @ObservedObject var locationCoordinator = NewRunCoordinator()
    @ObservedObject var timer = StopWatchManager()
    @State var showingAlert = false
    @State var error = ""
    @Environment(\.presentationMode) var presentationMode
    
    @State private var defaultRegion = MKCoordinateRegion(
        // Apple Park
        center: CLLocationCoordinate2D(latitude: 51, longitude: -114.1161533106428),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var localTimer: String {
        timer.printSecondsToHoursMinutesSeconds(seconds: Int(timer.secondsElapsed))
    }
    
    func saveToDevice(run: NewRun) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(run)
            UserDefaults.standard.set(data, forKey: "run")

        } catch {
            print("Unable to Encode run (\(error))")
        }
      
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
                                    timer.stop()

                                    do {
                                        try locationCoordinator.stop() {(res) in
                                            switch res {
                                            case .failure(let err):
                                                    self.error = err.message
                                                    self.showingAlert = true
                                                
                                            case .success(let run):
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                        }
                                    } catch {
                                        self.error = error.localizedDescription
                                        self.showingAlert = true
                                    }
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
                            }
                            .frame(height: geo.size.height * 0.3)
                           
                            
                        }
                    }
                   
                    
                   
                    Spacer()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(error), dismissButton: Alert.Button.default(Text("Ok")) {
                        presentationMode.wrappedValue.dismiss()
                    })
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
