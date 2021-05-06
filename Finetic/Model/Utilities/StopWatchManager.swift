//
//  StopWatchManager.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-26.
//

import Foundation
import SwiftUI

class StopWatchManager: ObservableObject {
    @Published var mode: stopWatchMode = .stopped
    @Published var secondsElapsed = 0.0
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { time in
            self.secondsElapsed += 0.01
        }
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
    
    func pause() {
        timer.invalidate()
        mode = .pause
    }
    
    enum stopWatchMode {
        case running, pause, stopped
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func printSecondsToHoursMinutesSeconds (seconds:Int) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds: seconds)
        return String(format: "%02i:%02i:%02i", h, m, s)
    }
    
}
