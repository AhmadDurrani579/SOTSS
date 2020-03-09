//
//  ProgramHeaderCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

protocol GridCellDelegate {
    func showGridCell(cell : ProgramHeaderCell , index : IndexPath)
    
}
class ProgramHeaderCell: UITableViewCell {

    var delegate : GridCellDelegate?
    var index : IndexPath?
    @IBOutlet weak var btnGrid: UIButton!
    @IBOutlet weak var lblDisplayDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnShowGridCell_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        self.delegate?.showGridCell(cell: self, index: index!)
    }
}
