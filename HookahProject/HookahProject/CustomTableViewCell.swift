//
//  CustomTableViewCell.swift
//  HookahProject
//
//  Created by DMITRY on 14/12/2019.
//  Copyright © 2019 Dmitry Smirnykh. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
