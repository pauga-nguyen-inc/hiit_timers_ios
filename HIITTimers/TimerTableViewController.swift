//
//  TimerTableViewController.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/9/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit

class TimerTableViewController: UITableViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var testTimer = TimerModel(timerName: "Tabata Timer", workingTime: 0.5, restTime: 0.06, description: "Your standard tabata timer", rounds: 5)
    
    var timers = [TimerModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.register(UINib(nibName: "TimerTableViewCell", bundle: nil), forCellReuseIdentifier: "TimerTableViewCell")
        timers.append(testTimer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //timers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell", for: indexPath) as! TimerTableViewCell

        let timer = timers[0] //indexPath.row]

        cell.titleLabel.text = timer.timerName
        cell.workingTimeLabel.text = String(timer.workingTime)
        cell.restTimeLabel.text = String(timer.restTime)
        cell.numberOfRoundsLabel.text = String(timer.rounds)
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timer = timers[indexPath.row]
        
        print("Timer Name: \(timer.timerName) \nTimer description: \(timer.description) \nWorking Time: \(timer.workingTime) \nRest time: \(timer.restTime)")
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
