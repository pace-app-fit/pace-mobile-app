//
//  WorkoutDetailsView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import SwiftUI
import URLImage

struct WorkoutDetailsView: View {
    var workout: Workout
    var controller: PlayerViewController
    
    @State private var isPlaying = false
  
    
    var body: some View {
            VStack{
                URLImage(url: URL(string: workout.thumbnail)!){image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame( height: 400)
                        .edgesIgnoringSafeArea(.top)
                        .clipped()
//                            .overlay(
//                                HStack {
//                                    Image("play")
//                                        .frame(width: 100)
//                                    Spacer()
//                                }
//                            )
                }
      
                
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(workout.user.userName)
                        .font(.title)
                        .foregroundColor(Color.pink)
                        .bold()
                    
                    
                    HStack(spacing: 20) {
                        HStack {
                            Image("clock")
                            Text(String(workout.time))
                                .italic()
                        }
                        
//                        HStack {
//                            Image("equip")
//                            Text(workout.equipment)
//                                .italic()
//                        }
                        
                        HStack {
                            Image("difficulty")
                            Text(workout.difficulty)
                                .italic()
                        }
                        
                    }
                    
                    .foregroundColor(.secondary)
                    .font(.headline)
                    
                    Divider()
                    
                    Text(workout.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .frame(width: 350)
                        .fixedSize(horizontal: false, vertical: true)
                  
                    HStack {
                        Spacer()
                        Button("Start") {
                            isPlaying = true
                        }
                        .buttonModifier()
                        Spacer()

                    }.padding(.top, 20)
                    .padding(.trailing, 180)

                    Spacer()
                }
                .clipped()
                .padding(.horizontal)
                
                    
            }
            .edgesIgnoringSafeArea(.top)
            .fullScreenCover(isPresented: $isPlaying, content: {
                FullScreenModalView.init(controller: controller)
            })
//            .sheet(isPresented: $isPlaying) {
//                controller
//                    .edgesIgnoringSafeArea(.all)
//            }
        
            
    }
    
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var controller: PlayerViewController


    var body: some View {
        controller
            .edgesIgnoringSafeArea(.all)
    }
}



