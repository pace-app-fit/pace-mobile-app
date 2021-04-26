//
//  NewTrackView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct NewTrackView: View {
    
    @ObservedObject var locationCoordinator = NewRunCoordinator()
    @State private var isPresented = false
    var body: some View {
        VStack {
            
            Button("Start run") {
                locationCoordinator.start()
                isPresented.toggle()
            }
            
            Button("Stop run") {
                locationCoordinator.stop()
            }
            
            
        }.fullScreenCover(isPresented: $isPresented, content: RunInProgressView.init)
    }
}

struct NewTrackView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrackView()
    }
}
