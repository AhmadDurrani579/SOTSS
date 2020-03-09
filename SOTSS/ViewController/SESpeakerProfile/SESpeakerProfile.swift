//
//  SESpeakerProfile.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SESpeakerProfile: UIViewController {

    @IBOutlet var tblView: UITableView!
    var responseObj: UserResponse?
    var userParticipantProgram : [ProgramsObject]?
    var participant  : ParticipationObject?
    var eventObj : EventObject?
    
    var isReadMorePressed : Bool?

    var userOfflineParticipantProgram : [ProgramModel]?
    var participantOffline  : Participation?
    var eventOffline : EventModel?
    
    var  arrayOfProgram : NSArray?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        userParticipantProgram = []
        userOfflineParticipantProgram = []
        isReadMorePressed = false

        if Connectivity.isConnectedToInternet() {
            
     
        
        for (_ , objOfProgram) in (self.responseObj?.result?.programSelect?.enumerated())! {
            
            for (_, particpantUser) in (objOfProgram.participant?.enumerated())! {
                
                if participant?.participant_id == particpantUser.participant_id {
                    userParticipantProgram?.append(objOfProgram)
                }
            }
            
        }
        } else {
            arrayOfProgram = ProgramModel.fetchAll() as NSArray?
            
            for (index , objOfProgram) in (arrayOfProgram?.enumerated())! {
                
                let obj = self.arrayOfProgram![index] as? ProgramModel
                 let particpantInProgram = obj?.participantInProgram?.allObjects as? [Participation]?
                for (indexCheck , particpantUser) in (particpantInProgram??.enumerated())! {
                    
                    let participate = particpantInProgram!![indexCheck] as! Participation
//                    let particpantInProgram = obj?.participantInProgram![indexCheck] as? Participation

                    if participantOffline?.participant_id == participate.participant_id {
                        self.userOfflineParticipantProgram?.append(objOfProgram as! ProgramModel)
                        
                    }
                }
                
            }
            

        }
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()

    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}

extension SESpeakerProfile : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            if Connectivity.isConnectedToInternet() {
                return (userParticipantProgram?.count)!

            } else {
                return (userOfflineParticipantProgram?.count)!

            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakerProfileCell", for: indexPath) as? SpeakerProfileCell
            if Connectivity.isConnectedToInternet() {
                cell?.lblUserName.text = participant?.participant_name
                cell?.lblDesignation.text = participant?.designation
                cell?.lblDetail.text = participant?.profile_desc
                WAShareHelper.loadImage(urlstring: (participant?.participant_photo)! , imageView: (cell?.lblUserProiflePic)!, placeHolder: "rectangle_placeholder")
                cell?.delegae = self
                cell?.index = indexPath

            } else {
                
                cell?.lblUserName.text = participantOffline?.participant_name
                cell?.lblDesignation.text = participantOffline?.designation
                cell?.lblDetail.text = participantOffline?.profile_desc
                WAShareHelper.loadImage(urlstring: (participantOffline?.participant_photo)! , imageView: (cell?.lblUserProiflePic)!, placeHolder: "rectangle_placeholder")

            }

            
            return cell!
        } else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDate", for: indexPath) as? SpeakerProfileCell
            if Connectivity.isConnectedToInternet() {
                cell?.lblEventTitle.text = eventObj?.event_title

            } else {
                cell?.lblEventTitle.text = eventOffline?.event_title

            }
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammCell", for: indexPath) as? ProgrammCell
            
            if Connectivity.isConnectedToInternet() {
                cell?.lblActivity_title.text = userParticipantProgram![indexPath.row].activity_title
                cell?.lblActivity_desc.text = userParticipantProgram![indexPath.row].activity_desc
                cell?.lblDisplay_date.text = userParticipantProgram![indexPath.row].display_date
                cell?.lblVenue_title.text = userParticipantProgram![indexPath.row].venue_title
                cell?.participation = userParticipantProgram![indexPath.row].participant
                cell?.collectionViewCell.reloadData()


            } else {
                cell?.lblActivity_title.text = userOfflineParticipantProgram![indexPath.row].activity_title
                cell?.lblActivity_desc.text = userOfflineParticipantProgram![indexPath.row].activity_desc
                cell?.lblDisplay_date.text = userOfflineParticipantProgram![indexPath.row].display_date
                cell?.lblVenue_title.text = userOfflineParticipantProgram![indexPath.row].venue_title
                
                let participateProgram = userOfflineParticipantProgram![indexPath.row].participantInProgram?.allObjects as? [Participation]?
                cell?.participationOffline = participateProgram!

//                cell?.participation = userParticipantProgram![indexPath.row].participant
                cell?.collectionViewCell.reloadData()


            }
            

            return cell!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if isReadMorePressed == true {
                return UITableViewAutomaticDimension
            } else {
                return 165.0
            }

        }  else if indexPath.section == 1 {
            return 49.0
        } else {
            return 210.0
        }
    }
    
}
extension SESpeakerProfile : ReadMoreProfile {


func readMoreButtonPressed(cell : SpeakerProfileCell , index : IndexPath) {
    if isReadMorePressed == false {
        isReadMorePressed = true
        cell.btnReadMore.setTitle("Read More", for: .normal)
        
        let indexPath = IndexPath(item: 0, section: 0)
        tblView.reloadRows(at: [indexPath], with: .none)
        
    } else {
        isReadMorePressed = false
        cell.btnReadMore.setTitle("Less", for: .normal)
        let indexPath = IndexPath(item: 0, section: 0)
        tblView.reloadRows(at: [indexPath], with: .none)
        
    }
    
}

}
