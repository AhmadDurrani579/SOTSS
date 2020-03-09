//
//  ParticipationListCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class ParticipationListCell: UITableViewCell {
    @IBOutlet var imgOfUser: UIImageView!
    @IBOutlet weak var lblNameOfParticipant: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
