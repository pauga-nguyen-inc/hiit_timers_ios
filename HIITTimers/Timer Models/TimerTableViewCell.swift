//
//  TimerTableViewCell.swift
//  HIITTimers
//
//  Created by Justin Pauga on 6/13/19.
//  Copyright © 2019 Justin Pauga. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {

    @IBOutlet weak var timerCardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var workingTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timerCardView.layer.cornerRadius = 10
        timerCardView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
