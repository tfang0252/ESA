//
//  RosterVCTableViewCell.swift
//  ESA
//
//  Created by Zachary Frederick on 10/26/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit

class RosterVCTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerNumberLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
