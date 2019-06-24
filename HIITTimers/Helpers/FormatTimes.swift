//
//  FormatTimes.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/23/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import Foundation

class FormatTimes {
    static func formatTimeForLabel(time: Int) -> String {
        if time < 10 {
            return "0\(time)"
        } else {
            return String(time)
        }
    }
}
