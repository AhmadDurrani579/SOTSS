//
//  HappeningCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 21/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class HappeningCell: UITableViewCell {
    @IBOutlet weak var lblTitleOfHappening: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLink: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
