//
//  TimerInfoService.swift
//  HIITTimers
//
//  Created by Justin Pauga on 7/2/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TimerInfoService {
    
    func saveTimer(_ timerToSave: TimerModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let newTimer = NSEntityDescription.entity(forEntityName: "Timer", in: managedContext) else { return }
        
        let timer = NSManagedObject(entity: newTimer, insertInto: managedContext)
        
        timer.setValue(timerToSave.workingTimeMinutes, forKey: "WorkingTimerMinutes")
        do {
            try managedContext.save()
        } catch let error as NSError {
            // Do some error shit
        }
    }
}
