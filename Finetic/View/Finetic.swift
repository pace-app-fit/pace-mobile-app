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
                VStack {
                    
                    
//                    ForEach(worksouts.workouts ?? []) { workout in
//                        FitnessCardView(workout: workout)
//                    }
                }
            }
            .navigationTitle("Finetic")
        }
    }
}

struct Finetic_Previews: PreviewProvider {
    static var previews: some View {
        Finetic()
    }
}
