//
//  NewTrackView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct NewTrackView: View {
    
    @State private var isPresented = false
    var body: some View {
        GeometryReader { geo in
            
        VStack {
            Spacer()
                Button("Start run") {
                    isPresented.toggle()
                }
                .modifier(ButtonModifier())
                .frame(width: geo.size.width * 0.5)
            Spacer()
            }
            
        }.fullScreenCover(isPresented: $isPresented, content: RunInProgressView.init)
    }
}

struct NewTrackView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrackView()
    }
}
