//
//  EventCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTitleOfEvent: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
//    @IBOutlet weak var viewOfEvent: UIView!
    @IBOutlet weak var viewOfBg: CardView!
    @IBOutlet weak var imgOfloc: UIImageView!
    
    
    @IBOutlet weak var imgOfCalend: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
