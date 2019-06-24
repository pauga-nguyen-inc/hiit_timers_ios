//
//  CreateTimerTableViewController.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/21/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit

private struct Constants {
    static let timerPickerValues = Array(0...60)
    static let roundsPickerValues = Array(0...30)
    static let workingTimePickerCellIndexPath = IndexPath(row: 1, section: 1)
    static let restTImePickerCellIndexPath = IndexPath(row: 1, section: 2)
    static let roundsPickerCellIndexPath = IndexPath(row: 1, section: 3)
}
class CreateTimerTableViewController: UITableViewController {

    @IBOutlet weak var timerTitleTextField: UITextField!
    @IBOutlet weak var workingTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var workingTimePicker: UIPickerView!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    @IBOutlet weak var restTimePicker: UIPickerView!
    @IBOutlet weak var numberOfRoundsPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var timer: TimerModel?
    
    var workingTimeMinutes: Int = 0
    var workingTimeSeconds: Int = 0
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
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let title = timerTitle {
            print(title)
        }
    }
    // MARK: Private Functions
    private func updateWorkingTimeLabel() {
        var minutes: String
        var seconds: String
        
        minutes = FormatTimes.formatTimeForLabel(time: workingTimeMinutes)
        seconds = FormatTimes.formatTimeForLabel(time: workingTimeSeconds)
        
        workingTimeLabel.text = "\(minutes):\(seconds)"
        updateSaveButtonState()
    }
    
    private func updateRestTimeLabel() {
        
        guard let restTimeMinutes = restTimeMinutes, let restTimeSeconds = restTimeSeconds else { return }
        
        var minutes: String = "--"
        var seconds: String = "--"
        
        minutes = FormatTimes.formatTimeForLabel(time: restTimeMinutes)
        seconds = FormatTimes.formatTimeForLabel(time: restTimeSeconds)
        
        restTimeLabel.text = "\(minutes):\(seconds)"
        updateSaveButtonState()
    }
    
    private func updateNumberOfRoundsLabel() {
        guard let numberOfRounds = numberofRounds else { return }
        
        numberOfRoundsLabel.text = String(numberOfRounds)
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        guard let rounds = numberofRounds else { return }
        
        if workingTimeMinutes > 0 || workingTimeSeconds > 0 {
            saveButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        if let title = timerTitle {
            timer?.timerName = title
        } else {
            timer?.timerName = "Timer 1"
        }
        timer?.workingTimeMinutes = workingTimeMinutes
        timer?.workingTimeSeconds = workingTimeSeconds
        
    }
}

extension CreateTimerTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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

extension CreateTimerTableViewController: UITextFieldDelegate {
    
}
