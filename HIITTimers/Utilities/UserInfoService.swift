//
//  SaveUserInfo.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/28/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import Foundation

struct userKeys {
    static let timers = "timers"
}

class UserInfoService {
    let defaults = UserDefaults.standard
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let propertyListDecoder = PropertyListDecoder()
    let propertyListEncoder = PropertyListEncoder()
    
    func saveTimers(timers: [TimerModel]) {
        //defaults.set(timers, forKey: userKeys.timers)
        let archiveUrl = documentsDirectory.appendingPathComponent(userKeys.timers).appendingPathExtension("plist")
        let encodedTimers = try? propertyListEncoder.encode(timers)
        try? encodedTimers?.write(to: archiveUrl, options: .noFileProtection)
    }
    
    func getTimers() -> [TimerModel] {
        //        if let timers = defaults.object(forKey: userKeys.timers) {
        //            return timers as! [TimerModel]
        //        }
        //        return [TimerModel]()
        var timers = [TimerModel]()
        let archiveUrl = documentsDirectory.appendingPathComponent(userKeys.timers).appendingPathExtension("plist")
        
        if let retrievedTimerData = try? Data(contentsOf: archiveUrl),
            let decodedTimers = try? propertyListDecoder.decode(Array<TimerModel>.self, from: retrievedTimerData) {
            timers = decodedTimers
        }
        
        return timers
    }
    
    func addTimer(_ timer: TimerModel) {
        var timers = getTimers()
        timers.append(timer)
        saveTimers(timers: timers)
    }
}
