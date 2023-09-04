//
//  Finetic.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
import AVKit

struct Finetic: View {
    @ObservedObject var workoutService = WorkoutService()
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(workoutService.workouts, id: \.self) { workout in
                    FitnessCardView(workout: workout)
                }
            }
            .navigationTitle("Pace")
                .onAppear {
                    workoutService.getWorkouts()
                }
        }
    }
}

struct Finetic_Previews: PreviewProvider {
    static var previews: some View {
        Finetic()
    }
}
