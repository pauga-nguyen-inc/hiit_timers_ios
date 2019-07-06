//
//  AddEditTimerTableViewController.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/21/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit
import CoreData

private struct Constants {
    static let timerPickerValues = Array(0...60)
    static let roundsPickerValues = Array(0...30)
    static let workingTimePickerCellIndexPath = IndexPath(row: 1, section: 1)
    static let restTImePickerCellIndexPath = IndexPath(row: 1, section: 2)
    static let roundsPickerCellIndexPath = IndexPath(row: 1, section: 3)
}
class AddEditTimerTableViewController: UITableViewController {

    @IBOutlet weak var timerTitleTextField: UITextField!
    @IBOutlet weak var workingTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var workingTimePicker: UIPickerView!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    @IBOutlet weak var restTimePicker: UIPickerView!
    @IBOutlet weak var numberOfRoundsPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let userInfoService = UserInfoService()
    var timer: TimerModel?
    
    var workingTimeMinutes: Int?
    var workingTimeSeconds: Int?
    var restTimeMinutes: Int?
    var restTimeSeconds: Int?
    var numberofRounds: Int?
    var timerTitle: String?
    
    var isWorkingTimePickerShown: Bool = false {
        didSet {
            workingTimePicker.isHidden = !isWorkingTimePickerShown
        }
    }
    
    var IsRestTimePickerShown: Bool = false {
        didSet {
            restTimePicker.isHidden = !IsRestTimePickerShown
        }
    }
    
    var isRoundsPickerShown: Bool = false {
        didSet {
            numberOfRoundsPicker.isHidden = !isRoundsPickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workingTimePicker.dataSource = self
        workingTimePicker.delegate = self
        restTimePicker.dataSource = self
        restTimePicker.delegate = self
        numberOfRoundsPicker.dataSource = self
        numberOfRoundsPicker.delegate = self
        
        tableView.separatorStyle = .none
        
        timerTitleTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        updateTimerView()
        updateSaveButtonState()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (Constants.workingTimePickerCellIndexPath.section, Constants.workingTimePickerCellIndexPath.row):
            if isWorkingTimePickerShown {
                return 100.0
            } else {
                return 0
            }
        case (Constants.restTImePickerCellIndexPath.section, Constants.restTImePickerCellIndexPath.row):
            if IsRestTimePickerShown {
                return 100.0
            } else {
                return 0
            }
        case (Constants.roundsPickerCellIndexPath.section, Constants.roundsPickerCellIndexPath.row):
            if isRoundsPickerShown {
                return 100.0
            } else {
                return 0
            }
        default: return 44.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let workingTimeMinutes = workingTimeMinutes,
            let workingTimeSeconds = workingTimeSeconds,
            let numberOfRounds = numberofRounds,
            segue.identifier == "saveUnwind"
            else { return }
        
        var timer = TimerModel()
        if let title = timerTitle {
            timer.timerName = title
        } else {
            timer.timerName = "Generic Timer"
        }
        timer.workingTimeMinutes = workingTimeMinutes
        timer.workingTimeSeconds = workingTimeSeconds
        if let restTimeMinutes = restTimeMinutes, let restTimeSeconds = restTimeSeconds {
            timer.restTimeMinutes = restTimeMinutes
            timer.restTimeSeconds = restTimeSeconds
        }
        timer.rounds = numberOfRounds
        
        self.timer = timer
        //userInfoService.addTimer(timer)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Section \(indexPath.section) and Row \(indexPath.row) tapped.")
        switch (indexPath.section, indexPath.row) {
        case (Constants.workingTimePickerCellIndexPath.section, Constants.workingTimePickerCellIndexPath.row - 1):
            isWorkingTimePickerShown = !isWorkingTimePickerShown
        case (Constants.restTImePickerCellIndexPath.section, Constants.workingTimePickerCellIndexPath.row - 1):
            IsRestTimePickerShown = !IsRestTimePickerShown
        case (Constants.roundsPickerCellIndexPath.section, Constants.roundsPickerCellIndexPath.row - 1):
            isRoundsPickerShown = !isRoundsPickerShown
        default: return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK IBActions
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            timerTitle = text
        }
    }
    

    // MARK: Private Functions
    private func updateWorkingTimeLabel() {
        var minutes: String = "--"
        var seconds: String = "--"
        
        if let workingTimeMinutes = workingTimeMinutes {
            minutes = FormatTimes.formatTimeForLabel(time: workingTimeMinutes)
            if workingTimeSeconds == nil {
                workingTimeSeconds = 0
                seconds = FormatTimes.formatTimeForLabel(time: workingTimeSeconds ?? 0)
            }
        }
        if let workingTimeSeconds = workingTimeSeconds {
            seconds = FormatTimes.formatTimeForLabel(time: workingTimeSeconds)
            if workingTimeMinutes == nil {
                workingTimeMinutes = 0
                minutes = FormatTimes.formatTimeForLabel(time: workingTimeMinutes ?? 0)
            }
        }
        
        workingTimeLabel.text = "\(minutes):\(seconds)"
        updateSaveButtonState()
    }
    
    private func updateRestTimeLabel() {
        
        var minutes: String = "--"
        var seconds: String = "--"
        
        if let restTimeMinutes = restTimeMinutes {
            minutes = FormatTimes.formatTimeForLabel(time: restTimeMinutes)
            if restTimeSeconds == nil {
                restTimeSeconds = 0
                seconds = FormatTimes.formatTimeForLabel(time: restTimeSeconds ?? 0)
            }
        }
        if let restTimeSeconds = restTimeSeconds {
            seconds = FormatTimes.formatTimeForLabel(time: restTimeSeconds)
            if restTimeMinutes == nil {
                restTimeMinutes = 0
                minutes = FormatTimes.formatTimeForLabel(time: restTimeMinutes ?? 0)
            }
        }
        
        restTimeLabel.text = "\(minutes):\(seconds)"
        updateSaveButtonState()
    }
    
    private func updateNumberOfRoundsLabel() {
        guard let numberOfRounds = numberofRounds else { return }
        
        numberOfRoundsLabel.text = String(numberOfRounds)
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        guard let workingTimeMinutes = workingTimeMinutes,
              let workingTimeSeconds = workingTimeSeconds,
              let rounds = numberofRounds
              else { return }
        
        if workingTimeMinutes > 0 || workingTimeSeconds > 0 {
            saveButton.isEnabled = true
        }
    }
    
    private func updateTimerView() {
        if let timer = timer {
            timerTitleTextField.text = timer.timerName
            workingTimeMinutes = timer.workingTimeMinutes
            workingTimeSeconds = timer.workingTimeSeconds
            numberofRounds = timer.rounds
            restTimeMinutes = timer.restTimeMinutes
            restTimeSeconds = timer.restTimeSeconds
        }
        updateNumberOfRoundsLabel()
        updateRestTimeLabel()
        updateWorkingTimeLabel()
    }
}

extension AddEditTimerTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == numberOfRoundsPicker {
            return 1
        }
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == numberOfRoundsPicker {
            return Constants.roundsPickerValues.count
        }
        return Constants.timerPickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == numberOfRoundsPicker {
            return "\(String(Constants.roundsPickerValues[row])) rounds"
        }
        
        if pickerView == workingTimePicker {
            switch component {
            case 0:
                return "\(String(Constants.timerPickerValues[row])) min"
            case 1:
                return "\(String(Constants.timerPickerValues[row])) sec"
            default:
                return String(Constants.timerPickerValues[row])
            }
        }
        
        if pickerView == restTimePicker {
            switch component {
            case 0:
                return "\(String(Constants.timerPickerValues[row])) min"
            case 1:
                return "\(String(Constants.timerPickerValues[row])) sec"
            default:
                return String(Constants.timerPickerValues[row])
            }
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case workingTimePicker:
            if component == 0 {
                workingTimeMinutes = row
            } else if component == 1 {
                workingTimeSeconds = row
            }
            updateWorkingTimeLabel()
        case restTimePicker:
            if component == 0 {
                restTimeMinutes = row
            } else if component == 1 {
                restTimeSeconds = row
            }
            updateRestTimeLabel()
        case numberOfRoundsPicker:
            numberofRounds = row
            updateNumberOfRoundsLabel()
        default:
            return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == numberOfRoundsPicker {
            return 200
        }
        return 100.00
    }
}

extension AddEditTimerTableViewController: UITextFieldDelegate {
    
}
