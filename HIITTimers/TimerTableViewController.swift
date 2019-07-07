//
//  TimerTableViewController.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/9/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit
import CoreData

class TimerTableViewController: UITableViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let userInfoService = UserInfoService()
    
    var testTimer = TimerModel(timerName: "Tabata Timer", workingTimeMinutes: 4, workingTimeSeconds: 30, restTimeMinutes: 1, restTimeSeconds: 0, rounds: 4)

    var timers: [TimerModel] = [TimerModel(timerName: "Tabata Timer", workingTimeMinutes: 4, workingTimeSeconds: 30, restTimeMinutes: 1, restTimeSeconds: 0, rounds: 4)]
    
    //var timers: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.register(UINib(nibName: "TimerTableViewCell", bundle: nil), forCellReuseIdentifier: "TimerTableViewCell")
        tableView.separatorStyle = .none
        //loadTimers()
        //timers.append(testTimer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell", for: indexPath) as! TimerTableViewCell

        //let timer = createTimerFromData(timer: timers[indexPath.row])
        let timer = timers[indexPath.row]
        
        cell.titleLabel.text = timer.timerName
        cell.workingTimeLabel.text = "\(FormatTimes.formatTimeForLabel(time: timer.workingTimeMinutes)):\(FormatTimes.formatTimeForLabel(time: timer.workingTimeSeconds))"
        cell.restTimeLabel.text = "\(FormatTimes.formatTimeForLabel(time: timer.restTimeMinutes)):\(FormatTimes.formatTimeForLabel(time: timer.restTimeSeconds))"
        cell.numberOfRoundsLabel.text = String(timer.rounds)
        cell.showsReorderControl = true
        
        return cell
    }
    
    private func createTimerFromData(timer: NSManagedObject) -> TimerModel {
        guard let name = timer.value(forKey: "timername") as? String,
            let workingTimeMinutes = timer.value(forKey: "workingtimeminutes") as? Int,
            let workingTimeSeconds = timer.value(forKey: "workingtimeseconds") as? Int,
            let restTimeMinutes = timer.value(forKey: "resttimeminutes") as? Int,
            let restTimeSeconds = timer.value(forKey: "resttimeseconds") as? Int,
            let numberOfRounds = timer.value(forKey: "numberofrounds") as? Int
            else { return TimerModel() }
        
        return TimerModel(timerName: name, workingTimeMinutes: workingTimeMinutes, workingTimeSeconds: workingTimeSeconds, restTimeMinutes: restTimeMinutes, restTimeSeconds: restTimeSeconds, rounds: numberOfRounds)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timer = timers[indexPath.row]

        let storyBoard = UIStoryboard(name: "CountDown", bundle: nil)
        self.present((storyBoard.instantiateViewController(withIdentifier: "CountDown") as? CountDownViewController)!, animated: true, completion: nil)
//        guard let timerCountDownViewController = storyBoard.instantiateViewController(withIdentifier: "CountDown") as? CountDownViewController else { return }
        
        
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            timers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }    
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let timerToMove = timers.remove(at: sourceIndexPath.row)
        timers.insert(timerToMove, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }

    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        guard unwindSegue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = unwindSegue.source as! AddEditTimerTableViewController
        
        if let timer = sourceViewController.timer {
            let newIndexPath = IndexPath(row: timers.count, section: 0)
            timers.append(timer)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = unwindSegue.source as! AddEditTimerTableViewController
        
        if let timer = sourceViewController.timer {
            let newIndexPath = IndexPath(row: timers.count, section: 0)
            timers.append(timer)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "editTimerSegue" {
//            let indexPath = tableView.indexPathForSelectedRow!
//            let timer = timers[indexPath.row]
//            let addEditTimerTableViewController = segue.destination as! AddEditTimerTableViewController
//            addEditTimerTableViewController.timer = timer
//        }
        
        tableView.reloadData()
    }
    
    private func loadTimers() {
        timers = userInfoService.getTimers()
    }
}
