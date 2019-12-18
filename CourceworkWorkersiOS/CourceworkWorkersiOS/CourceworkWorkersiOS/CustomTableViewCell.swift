//
//  CustomTableViewCell.swift
//  CourceworkWorkersiOS
//
//  Created by DMITRY on 12/12/2019.
//  Copyright © 2019 Dmitry Smirnykh. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var yearCell: UILabel!
    @IBOutlet weak var positionCell: UILabel!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var photoCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
