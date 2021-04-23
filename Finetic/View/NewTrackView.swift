//
//  NewTrackView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI

struct NewTrackView: View {
    
    
    var body: some View {
        VStack {
            NewRunMapView()
            Button("Start run") {
                
            }
            
            Spacer()
          
            Spacer()
        }
    }
}

struct NewTrackView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrackView()
    }
}
