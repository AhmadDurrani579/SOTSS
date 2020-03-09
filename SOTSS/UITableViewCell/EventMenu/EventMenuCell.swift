//
//  EventMenuCell.swift
//  SOT Events
//
//  Created by Hafiz Aziz on 18/10/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class EventMenuCell: UITableViewCell {
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var imgMenu: UIImageView!
//    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    func refreshView(section : Int)  {
//        if section == 0 {
//            self.contentView.backgroundColor = UIColor.yellow
//            self.lblNAme
//        }
//        
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
