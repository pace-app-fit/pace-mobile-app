//
//  NewTrackView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct NewTrackView: View {
    
    @ObservedObject var location = NewRunLocationManager()
    
    var body: some View {
        VStack {
            Spacer()
            Button("Start run") {
                location.startRecording()
            }
            
            Spacer()
            Button("Submit Run") {
                location.createRun(name: "iOS test", coords: location.locations ?? [])
            }
            Spacer()
        }
    }
}

struct NewTrackView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrackView()
    }
}
