//
//  SpeakerProfileCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
@objc protocol ReadMoreProfile {
    @objc optional func readMoreButtonPressed(cell : SpeakerProfileCell , index : IndexPath)

}
class SpeakerProfileCell: UITableViewCell {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDetail: UILabel!

    @IBOutlet weak var lblUserProiflePic: UIImageView!
  
    @IBOutlet weak var lblEventTitle: UILabel!
    var index  : IndexPath?
    var delegae : ReadMoreProfile?
    @IBOutlet weak var btnReadMore: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnReadMoreOrLessButton_Pressed(_ sender: UIButton) {
         sender.isSelected = !sender.isSelected
        self.delegae?.readMoreButtonPressed!(cell: self, index: index!)
        
        
    }

}
