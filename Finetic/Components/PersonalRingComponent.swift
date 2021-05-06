//
//  PersonalWeeklyStatsComponent.swift
//  Finetic
//
//  Created by Tapiwa on 2021-05-03.
//

import SwiftUI

struct PersonalRingComponent: View {
    let ringWidth: CGFloat = 20
    let percent: Double
    var backgroundColor: Color {
        foregroundColor.opacity(0.3)
    }
    let foregroundColor: Color
    let startAngle: Double = -90
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    RingShape(percent: 100)
                        .stroke(style: StrokeStyle(lineWidth: self.ringWidth))
                        .fill(self.backgroundColor)
                    RingShape(percent: self.percent, startAngle: self.startAngle)
                        .stroke(style: StrokeStyle(lineWidth: self.ringWidth, lineCap:.round))
                        .fill(self.foregroundColor)
                    Text("13 km")
                }
                .padding(.vertical, 0)
                
                Text("Label")
                
                
            }
           
        }
        .padding()
    }
}

