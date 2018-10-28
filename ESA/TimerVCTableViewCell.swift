//
//  TimerVCTableViewCell.swift
//  ESA
//
//  Created by Zachary Frederick on 10/28/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit

class TimerVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerTimeSwitch: UISwitch!
    
    @IBAction func playerSubbed(_ sender: Any) {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
