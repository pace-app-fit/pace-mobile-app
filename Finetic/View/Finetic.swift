//
//  Finetic.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
import AVKit

struct Finetic: View {
    let player = AVPlayer(url: URL(string: "https://res.cloudinary.com/dnmlpwow2/video/upload/v1612224779/RPReplay_Final1612222370_up45oi.mov")!)
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                
            }
            .navigationTitle("Aleesha's Finetic")
        }
    }
}

struct Finetic_Previews: PreviewProvider {
    static var previews: some View {
        Finetic()
    }
}
