//
//  SwiftUIView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-05-03.
//

import SwiftUI

struct RingShape: Shape {
    private var percent: Double
    private var startAngle: Double
    private var drawnClockwise: Bool
    
    var animatableData: Double {
        get {
            percent
        }
        set {
            percent = newValue
        }
    }
    
    static func percentToAngle(percent: Double, startAngle: Double) -> Double {
        (percent / 100 * 360) + startAngle
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(width, height) / 2
        let center = CGPoint(x: width / 2, y: height / 2)
        let endAngle = Angle(degrees: RingShape.percentToAngle(percent: self.percent, startAngle: self.startAngle))
        
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: endAngle, clockwise: !drawnClockwise)
        }
    }
    
    init(percent: Double, startAngle: Double = -90) {
        self.percent = percent
        self.startAngle = startAngle
        self.drawnClockwise = true
    }
    
    
}


