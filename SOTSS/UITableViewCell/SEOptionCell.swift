//
//  SEOptionCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 26/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEOptionCell: UITableViewCell {

    @IBOutlet weak var lblOption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnChoiseOption_Selected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    
}
