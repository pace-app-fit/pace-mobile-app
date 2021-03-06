//
//  FitnessCardView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import SwiftUI
import Combine
import Foundation
import URLImage

struct FitnessCardView: View {
    
    var workout: Workout
    

    
    var body: some View {
        NavigationLink(destination: WorkoutDetailsView(workout: workout)) {
            VStack(alignment: .leading) {
                URLImage(url: workout.heroURL!) { image in
                    image
                        .resizable()
                        .frame(idealWidth: 400, idealHeight: 300)
                        .scaledToFit()
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Spacer()
                                VStack {
                                    Image(systemName: "bookmark")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                
                            }
                        )
                        
                }
                   
                  
               
                Text(workout.name)
                    .font(.largeTitle)
                    .bold()
                    .accentColor(Color.primary)
                    
                
                Text(workout.createdBy)
                    .font(.title)
                    .foregroundColor(Color.pink)
                    .bold()
                HStack {
                    HStack {
                        Image("clock")
                        Text(workout.time)
                            .italic()
                    }
                    
                    HStack {
                        Image("equip")
                        Text(workout.equipment)
                            .italic()
                            
                    }
                    
                }
                
                .foregroundColor(.secondary)
                .font(.headline)
                
                Text(workout.workoutDescription)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                
                
                Divider()
            }
            
        }
       
        
        .padding()
       
    }
}

