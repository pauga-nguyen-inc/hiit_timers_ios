//
//  CreateTimerViewController.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/15/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit

class CreateTimerViewController: UIViewController {

    @IBOutlet weak var timerTitleTextField: UITextField!
    @IBOutlet weak var workingTimePicker: UIPickerView!
    @IBOutlet weak var restTimePicker: UIPickerView!
    @IBOutlet weak var workingTimeInfoLabel: UILabel!
    
    var timer: TimerModel?
    let workingTimePickerValues = Array(0...60)
    let restTimePickerValues = Array(0...60)
    var workingTimeMinutes: Int = 0
    var workingTimeSeconds: Int = 0
    var restTimeMinutes: Int = 0
    var restTimeSeconds: Int = 0
    
//    private var minutes: Int
//    private var seconds: Int
    override func viewWillAppear(_ animated: Bool) {
        workingTimePicker?.superview?.isHidden = true
        restTimePicker?.superview?.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.workingTimePicker.delegate = self
        self.workingTimePicker.dataSource = self
        self.restTimePicker.delegate = self
        self.restTimePicker.dataSource = self
        
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }   
}

// MARK: - PickerView delegate methods

extension CreateTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == workingTimePicker {
            return workingTimePickerValues.count
        }
        return workingTimePickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(workingTimePickerValues[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            workingTimeMinutes = row
        } else if component == 1 {
            workingTimeSeconds = row
        }
    }
}
