//
//  AllTaskCell.swift
//  MainTask
//
//  Created by кирилл корнющенков on 04.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit

class AllTaskCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
