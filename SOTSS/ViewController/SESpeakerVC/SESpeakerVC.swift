//
//  SESpeakerVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import ActionSheetPicker_3_0

class SESpeakerVC: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet var tblView: UITableView!
    var eventObj : EventObject?
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    @IBOutlet weak var btnChoseRole: UIButton!
    @IBOutlet weak var lblEventName: UILabel!

    var participantInEvent : [ParticipationObject]?
    var objOfParticipant : [ParticipationObject]?
    
    var filters   : [ParticipationObject]?

    var isFilterApply : Bool?
    var speakerResponse : UserResponse?
//    var idOfUniversity : String?
    var searchActive : Bool = false

    @IBOutlet weak var searchBar: UISearchBar!
    
    var  thread : Participation?
    var arrayOfParticipation : NSArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "ParticipationListCell", bundle: nil), forCellReuseIdentifier: "ParticipationListCell")
        participantInEvent = []
        objOfParticipant = []
        
        lblEventName.text = eventObj?.event_title
        if self.responseObj?.result?.programSelect == nil {
       
        }
        else {
            for (_ , objOfProgram) in (self.responseObj?.result?.programSelect?.enumerated())! {
                
                for (_, particpantUser) in (objOfProgram.participant?.enumerated())! {
                    participantInEvent?.append(particpantUser)
                    
                    arrayOfParticipation = Participation.fetchAll() as NSArray?
                    let resultPredicate = NSPredicate(format: "participant_id == %@", particpantUser.participant_id!)
                    let arrayOfFilter = arrayOfParticipation?.filtered(using: resultPredicate)
                    
                    if (arrayOfFilter?.count)! > 0 {
                        
                    } else {
                        thread = Participation.create() as? Participation
                        thread?.participant_id = particpantUser.participant_id
                        thread?.participant_name = particpantUser.participant_name
                        thread?.participant_photo = particpantUser.participant_photo
                        thread?.designation = particpantUser.designation
                        thread?.profile_desc = particpantUser.profile_desc
                        thread?.role_id = particpantUser.role_id
                        thread?.role_desc = particpantUser.role_desc
                        thread?.gender = particpantUser.gender
                        thread?.linkedin_url = particpantUser.linkedin_url
                        thread?.twitter_url = particpantUser.twitter_url
                        thread?.sub_designation = particpantUser.sub_designation ?? " "
                        thread?.experties = particpantUser.experties ?? " "
                        thread?.linkedin_url = particpantUser.linkedin_url ?? " "
                        thread?.twitter_url = particpantUser.twitter_url ?? " "
                        Participation.save()
                    }
                    

                    
                    
                    
                }
                
            }
            self.tblView.delegate = self
            self.tblView.dataSource = self
            self.tblView.reloadDataWithAutoSizingCellWorkAround()
        }
        self.isFilterApply = true

        
        getTheEventParticipant()

        //        getTheEventParticipant()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTheEventParticipant(){
        
        let eventId = eventObj?.event_id
        let loginParam =  [ "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SPEAKER_LIST, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.speakerResponse = response as? UserResponse
            
            if self.speakerResponse?.success == 1 {
                
                
            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    }
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChoseRole_Pressed(_ sender: UIButton) {
        
        var allRole = [String]()
        self.objOfParticipant = []
        for (_ , info) in (self.speakerResponse?.result?.participentRole?.enumerated())! {
            allRole.append(info.role_desc!)
        }
        ActionSheetStringPicker.show(withTitle: "Select Categories", rows: allRole , initialSelection: 0 , doneBlock: { (picker, index, value) in
            
            let category = self.speakerResponse?.result?.participentRole![index]
            self.isFilterApply = false
            self.btnChoseRole.setTitle(category?.role_desc , for: .normal)
            
            
            for(_ , participant) in (self.participantInEvent?.enumerated())!{
                
                if participant.role_id == category?.role_id {
                    self.objOfParticipant?.append(participant)
                }
            
            }
            self.tblView.reloadData()
            
            
            
//            self.idOfUniversity = category?.id
            
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
        }, cancel: { (actionStrin ) in

        }, origin: sender)
        
    }
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }

}

extension SESpeakerVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        var numOfSections: Int = 0
//        if  self.participantInEvent?.isEmpty == false {
//            numOfSections = 2
//            tblView.backgroundView = nil
//        }
//        else {
//            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
//            noDataLabel.numberOfLines = 10
//            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
//                noDataLabel.font = aSize
//            }
//            noDataLabel.text = "There are currently no data."
//            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
//            noDataLabel.textAlignment = .center
//            tblView.backgroundView = noDataLabel
//            tblView.separatorStyle = .none
//        }
//        return numOfSections
                    return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFilterApply == true  {
            return (self.participantInEvent?.count)!
        } else {
            return (objOfParticipant?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipationListCell", for: indexPath) as? ParticipationListCell
        
        if isFilterApply == true {
            WAShareHelper.loadImage(urlstring: (participantInEvent![indexPath.row].participant_photo)! , imageView: (cell?.imgOfUser)!, placeHolder: "rectangle_placeholder")
            cell?.lblNameOfParticipant.text = participantInEvent![indexPath.row].participant_name
            cell?.lblDesignation.text = participantInEvent![indexPath.row].designation
            
        } else {
            WAShareHelper.loadImage(urlstring: (objOfParticipant![indexPath.row].participant_photo)! , imageView: (cell?.imgOfUser)!, placeHolder: "rectangle_placeholder")
            cell?.lblNameOfParticipant.text = objOfParticipant![indexPath.row].participant_name
            cell?.lblDesignation.text = objOfParticipant![indexPath.row].designation
        }
      
        return cell!
            
            
      
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerProfile") as? SESpeakerProfile
        if isFilterApply == true {
            vc?.participant = self.participantInEvent![indexPath.row]

        } else {
            vc?.participant = self.objOfParticipant![indexPath.row]

        }
        vc?.responseObj = self.responseObj
        vc?.eventObj = self.eventObj
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0

        
//        if indexPath.section == 0 {
//            return 52.0
//        }  else {
//            return 197.0
//        }
    }
    
}

extension SESpeakerVC : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.text = ""
        searchBar.placeholder = "Search"
        searchBar.resignFirstResponder()
        self.tblView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if isFilterApply == true {
            filters = participantInEvent?.filter { ($0.participant_name?.lowercased().contains(searchText.lowercased()))! }
            self.tblView.reloadData()
        } else {
            filters = objOfParticipant?.filter { ($0.participant_name?.lowercased().contains(searchText.lowercased()))! }
            self.tblView.reloadData()

        }
        self.searchBar.showsCancelButton = true
        searchActive = true
        
        
    }
    
    //    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    //        searchActive = false
    //        self.searchBar.endEditing(true)
    //
    ////        searchBar.becomeFirstResponder()
    //        return true
    //    }
    //
    //    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    //        tblView.isHidden = false
    //        return true
    //
    //    }
    //
    //    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    //        self.view.endEditing(true)
    //        self.searchBar.endEditing(true)
    //        searchBar.resignFirstResponder()
    //    }
    //
    //    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    ////        tblView.isHidden = true
    ////        searchActive = true
    ////        searchBar.text = ""
    ////        searchBar.placeholder = "Search"
    ////        searchBar.resignFirstResponder()
    ////        self.tblView.reloadData()
    //
    ////        self.searchBar.endEditing(false)
    ////        searchBar.becomeFirstResponder()
    //
    //    }
    //
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        searchBar.resignFirstResponder()
    //    }
}

