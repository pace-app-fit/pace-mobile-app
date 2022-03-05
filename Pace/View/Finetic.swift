//
//  Finetic.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
import AVKit

struct Finetic: View {
    @ViewBuilder
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Screen under construction...")
                    .bold()
                    .padding(.top, 250)
            }
            .navigationTitle("Pace")
        }
    }
}

struct Finetic_Previews: PreviewProvider {
    static var previews: some View {
        Finetic()
    }
}
