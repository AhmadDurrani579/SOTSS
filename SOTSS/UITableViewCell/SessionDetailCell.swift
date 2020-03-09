//
//  SessionDetailCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
@objc protocol ReadMore {
    @objc optional func readMoreButtonPressed(cell : SessionDetailCell , index : IndexPath)
    func AskQuestion(cell : SessionDetailCell , index : IndexPath)
    func evaluationOfProgram(cell: SessionDetailCell, index: IndexPath)
    func PollOfProgram(cell: SessionDetailCell, index: IndexPath)
    func registerUserForProgram(cell : SessionDetailCell , indexCheck : IndexPath)
    func UnRegisterUserForProgram(cell : SessionDetailCell , indexCheck : IndexPath)

}

class SessionDetailCell: UITableViewCell {
    @IBOutlet weak var lblActivity_title: UILabel!
    @IBOutlet weak var lblActivity_desc: UILabel!
    @IBOutlet weak var lblDisplay_date: UILabel!
    @IBOutlet weak var lblVenue_title: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnUnRegister: UIButton!

    
    
    var index  : IndexPath?
    var delegae : ReadMore?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAskQuestion_Pressed(_ sender: UIButton) {
        self.delegae?.AskQuestion(cell: self, index: index!)
    }
    
    @IBAction func btnReadMoreOrLessButton_Pressed(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        self.delegae?.readMoreButtonPressed!(cell: self, index: index!)


    }
    
    @IBAction func btnEvaluation_Pressed(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        self.delegae?.evaluationOfProgram(cell: self, index: index!)
        
    }
    
    @IBAction func btnPoll_Pressed(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        self.delegae?.PollOfProgram(cell: self, index: index!)
        
    }
    
    @IBAction func btnRegisterButton_Pressed(_ sender: UIButton) {
        //        sender.isSelected =  !sender.isSelected
        self.delegae?.registerUserForProgram(cell: self , indexCheck: index!)
    }
    
    @IBAction func btnUnRegister(_ sender: UIButton) {
        //        sender.isSelected =  !sender.isSelected
        self.delegae?.UnRegisterUserForProgram(cell: self , indexCheck: index!)
    }

    
}
