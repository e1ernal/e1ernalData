//
//  FindWorkerCell.swift
//  MainTask
//
//  Created by кирилл корнющенков on 04.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit

class FindWorkerCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!{
        didSet{
            imageCell.layer.cornerRadius = imageCell.frame.height / 2
            imageCell.clipsToBounds = true
            imageCell.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCell.contentMode = .scaleAspectFit
        nameLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let sizeImage = (frame.height - 5 ) * 3 / 5
        imageCell.frame = CGRect(x: (frame.width - sizeImage) / 2, y: 5, width: sizeImage, height: sizeImage)
        nameLabel.frame = CGRect(x: 5, y: (frame.height - 5) * 3 / 5, width: frame.width - 10, height: frame.height * 2 / 5)
    }
}
