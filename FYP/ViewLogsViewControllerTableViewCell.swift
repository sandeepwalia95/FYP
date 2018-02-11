//
//  ViewLogsViewControllerTableViewCell.swift
//  FYP
//
//  Created by Sandeep Walia on 03/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

class ViewLogsViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var firstMoodColor: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var activityOne: UILabel!
    @IBOutlet weak var activityTwo: UILabel!
    @IBOutlet weak var activityThree: UILabel!
    @IBOutlet weak var activityFour: UILabel!
    @IBOutlet weak var activityFive: UILabel!
    @IBOutlet weak var activitySix: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
