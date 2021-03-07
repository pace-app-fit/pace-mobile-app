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
         
        GeometryReader{geo in
            VStack{
                URLImage(url: workout.heroURL!){image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame( height: CGFloat(geo.size.height * 0.6))
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
                    
                    Text(workout.createdBy)
                        .font(.title)
                        .foregroundColor(Color.pink)
                        .bold()
                    
                    
                    HStack(spacing: 20) {
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
                        
                        HStack {
                            Image("difficulty")
                            Text(workout.difficulty)
                                .italic()
                        }
                        
                    }
                    
                    .foregroundColor(.secondary)
                    .font(.headline)
                    
                    Divider()
                    
                    Text(workout.workoutDescription)
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
    
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var controller: PlayerViewController


    var body: some View {
        controller
            .edgesIgnoringSafeArea(.all)
    }
}

//struct WorkoutDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutDetailsView(workout: devWorkout)
//    }
//}

var devWorkout = Workout(id: "test", name: "Guided Yoga", createdBy: "Aleesha Gettis", videoURL: "https://res.cloudinary.com/dnmlpwow2/video/upload/v1612224779/RPReplay_Final1612222370_up45oi.mov", equipment: "None", difficulty: "Beginner", time: "7 min", workoutDescription: "Guided Yoga to clear your mind and relax the body. Get your session in!", heroimg: "https://res.cloudinary.com/dnmlpwow2/image/upload/v1615055635/yoga2_2x_rksqsz.png", v: 1)


