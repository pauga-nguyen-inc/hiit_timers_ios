//
//  TimerModel.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/2/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import Foundation

struct TimerModel: Codable {
    var timerName: String
    var workingTimeMinutes: Int
    var workingTimeSeconds: Int
    var restTimeMinutes: Int
    var restTimeSeconds: Int
    var rounds: Int
    
    init() {
        self.timerName = ""
        self.workingTimeMinutes = -1
        self.workingTimeSeconds = -1
        self.restTimeMinutes = 0
        self.restTimeSeconds = 0
        self.rounds = 0
    }
    
    init(timerName: String, workingTimeMinutes: Int, workingTimeSeconds: Int, restTimeMinutes: Int?, restTimeSeconds: Int?, rounds: Int) {
        self.timerName = timerName
        self.workingTimeMinutes = workingTimeMinutes
        self.workingTimeSeconds = workingTimeSeconds
        self.restTimeMinutes = restTimeMinutes ?? 0
        self.restTimeSeconds = restTimeSeconds ?? 0
        self.rounds = rounds
    }
}
