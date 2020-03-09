//
//  FaqEventCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 21/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class FaqEventCell: UITableViewCell {
    @IBOutlet weak var lblQuestionTitle: UILabel!
    @IBOutlet weak var lblQuestionDetail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
