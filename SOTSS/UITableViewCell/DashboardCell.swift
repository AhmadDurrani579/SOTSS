//
//  DashboardCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class DashboardCell: UITableViewCell {

    @IBOutlet weak var lblTitleOfHeading: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var imgeOfTile: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
