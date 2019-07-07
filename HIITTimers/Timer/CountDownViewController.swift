//
//  CountDownViewController.swift
//  HIITTimers
//
//  Created by Justin Pauga on 7/5/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {

    var timer: TimerModel?
    @IBOutlet weak var timerTitle: UILabel!
    @IBOutlet weak var workRestLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let timer = timer else { return }
        
        timerTitle.text = timer.timerName
        workRestLabel.text = "Hit Button to start!"
        timerLabel.text = "\(String(timer.workingTimeMinutes)):\(String(timer.workingTimeSeconds))"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
