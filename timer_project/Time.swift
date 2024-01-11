//
//  Clock.swift
//  timer_project
//
//  Created by Joel Martin on 12/8/23.
//

import Foundation
import UIKit

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int

    init(totalSeconds: Int) {
        hours = totalSeconds / (60 * 60)
        minutes = (totalSeconds % (60 * 60)) / 60
        seconds = totalSeconds % 60
    }
    
    var timeString: String {
        let hourString = getTimeString(time: hours)
        let minuteString = getTimeString(time: minutes)
        let secondString = getTimeString(time: seconds)
        return "\(hourString):\(minuteString):\(secondString)"
    }

    private func getTimeString(time: Int) -> String {
        return (time > 9) ? "\(time)" : "0\(time)"
    }
}
