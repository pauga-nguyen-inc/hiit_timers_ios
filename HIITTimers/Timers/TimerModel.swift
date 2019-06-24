//
//  TimerModel.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/2/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import Foundation

struct TimerModel {
    var timerName: String
    var workingTimeMinutes: Int
    var workingTimeSeconds: Int
    var restTimeMinutes: Int = 0
    var restTimeSeconds: Int = 0
    var rounds: Int
}
