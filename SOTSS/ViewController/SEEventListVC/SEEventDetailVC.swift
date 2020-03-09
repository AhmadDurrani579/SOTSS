//
//  SEEventDetailVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class SEEventDetailVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet var tblView: UITableView!
    var eventObj : EventObject?
    var eventOffline : EventModel?

    let size = CGSize(width: 60, height: 60)
    var responseProgramTime: UserResponse?
    
    var isFirstDate : [ProgramsObject]?
    var isSecondDate : [ProgramsObject]?
    
    var isOfflineFirstDate : [ProgramModel]?
    var isOfflineSecondDate : [ProgramModel]?

    var responseObj: UserResponse?

    var firstDateCheck : String?
    var secondDateCheck : String?
    
    var  programThread : ProgramModel?
    var  programParticpant : Participation?

    var  arrayOfProgram : NSArray?

    
    let items = ["PROGRAMMES" , "SPEAKERS" , "MY SESSIONS" , "HAPPENINGS" ,"INFORMATION DESK" ,"CONCERT", "FULL STEAM", "MEDIA","SPONSORS & EXHIBITORS", "EVALUATION" , "SOT TEAM"]
    let itemImage = ["program" , "microphone" , "program" , "happenings" ,"informationDesk" , "fullsteam", "evaluation","evaluation","evaluation" ,"evaluation" , "team"]

    let subDetail = ["Schedule for my registerd sessions" , "Updated News" , "Get directions, FAQ, ask a question","Event entertainment" , "IT exihibits","Contributions, resource and press coverage" ,"Event sponsors an exihibitors" ,"Event Feedback" , "Team Information"]
    
    
    // array define for Grid
    
    var isHall1List : [ProgramsObject]?
    var isHall2List : [ProgramsObject]?
    var isHall3List : [ProgramsObject]?
    var isHall4List : [ProgramsObject]?


    override func viewDidLoad() {
        super.viewDidLoad()
        isFirstDate = []
        isSecondDate = []
        isOfflineFirstDate = []
        isOfflineSecondDate = []
        
        isHall1List = []
        isHall2List = []
        isHall3List = []
        isHall4List = []

        tblView.register(UINib(nibName: "DashboardHeaderCell", bundle: nil), forCellReuseIdentifier: "DashboardHeaderCell")
        tblView.register(UINib(nibName: "DashboardCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadDataWithAutoSizingCellWorkAround()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if Connectivity.isConnectedToInternet() {
            getTheProgramOfUser()
            
        } else {
            arrayOfProgram = ProgramModel.fetchAll() as NSArray?
            let objOfProgram = self.arrayOfProgram![0] as? ProgramModel
            self.firstDateCheck = objOfProgram?.activity_date
            
            
            if self.firstDateCheck != nil {
                
                for (index , _) in (arrayOfProgram?.enumerated())! {
                    
                    let program = self.arrayOfProgram![index] as? ProgramModel
                    
                    
                    if program?.activity_date == self.firstDateCheck {
                        self.isOfflineFirstDate?.append(program!)
                    }
                    else {
                        self.secondDateCheck = program?.activity_date
                        
                        if program?.activity_date == self.secondDateCheck {
                            self.isOfflineSecondDate?.append(program!)
                        }
                        
                    }
                    
                }
            }
            
            
            
            
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "gotoProgram") , object: nil, queue: nil) { notification in
            if let userInfo = notification.userInfo {
                if userInfo["isFromMenu"] as! Bool
                {
                    self.gotoProgram(isFromMenu: true)
                }
            }
        }
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }

    
    
    func getTheProgramOfUser(){
        let idOfUser = UserDefaults.standard.integer(forKey: "id")

//        let userId = localUserData.user_id
        let eventId = eventObj?.event_id
        let loginParam =  [ "user_id"         : "\(idOfUser)" ,
                            "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROGRAME, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            self.responseObj = response as? UserResponse

            if self.responseObj?.success == 1 {
                
                self.firstDateCheck = self.responseObj?.result?.programSelect![0].activity_date
                if self.firstDateCheck == nil {
                    
                } else {
                    self.storeProgramOffline(program: self.responseObj!)
                    
                    if self.firstDateCheck != nil {
                        
                        for (_ , objOfProgram) in (self.responseObj?.result?.programSelect?.enumerated())! {
                            
                            if objOfProgram.activity_date == self.firstDateCheck {
                                self.isFirstDate?.append(objOfProgram)
                                if objOfProgram.venue_title == "Hall 1 (Auditorium)" {
                                    self.isHall1List?.append(objOfProgram)
                                    
                                } else if objOfProgram.venue_title == "Hall 2" {
                                    self.isHall2List?.append(objOfProgram)
                                    
                                } else if objOfProgram.venue_title == "Hall 3" {
                                    self.isHall3List?.append(objOfProgram)
                                    
                                } else if objOfProgram.venue_title == "Hall 4 (Conference Room)" {
                                    self.isHall4List?.append(objOfProgram)
                                    
                                }
                            }
                            else {
                                self.secondDateCheck = objOfProgram.activity_date
                                
                                if objOfProgram.activity_date == self.secondDateCheck {
                                    self.isSecondDate?.append(objOfProgram)
                                    
                                    if objOfProgram.venue_title == "Hall 1 (Auditorium)" {
                                        self.isHall1List?.append(objOfProgram)
                                        
                                    } else if objOfProgram.venue_title == "Hall 2" {
                                        self.isHall2List?.append(objOfProgram)
                                        
                                    } else if objOfProgram.venue_title == "Hall 3" {
                                        self.isHall3List?.append(objOfProgram)
                                        
                                    } else if objOfProgram.venue_title == "Hall 4 (Conference Room)" {
                                        self.isHall4List?.append(objOfProgram)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                }


//                self.tblView.delegate = self
//                self.tblView.dataSource = self
//                self.tblView.reloadDataWithAutoSizingCellWorkAround()
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
    
    func storeProgramOffline(program : UserResponse) {
     
        for (_ , obj) in (program.result?.programSelect?.enumerated())! {
            
            arrayOfProgram = ProgramModel.fetchAll() as NSArray?
            let resultPredicate = NSPredicate(format: "schedule_id == %@", obj.schedule_id!)
            let arrayOfFilter = arrayOfProgram?.filtered(using: resultPredicate)
            
            if (arrayOfFilter?.count)! > 0 {
                
            } else {
                
                programThread = ProgramModel.create() as? ProgramModel
//                programParticpant = Participation.create() as? Participation
                programThread?.event_id = obj.event_id
                programThread?.schedule_id = obj.schedule_id
                programThread?.user_id = obj.user_id
                programThread?.poll_exists = obj.poll_exists
                programThread?.poll_active = obj.poll_active
                programThread?.poll_submitted = obj.poll_submitted
                programThread?.evaluation_exists = obj.evaluation_exists
                programThread?.evaluation_active = obj.evaluation_active
                programThread?.evaluation_submitted = obj.evaluation_submitted
                programThread?.attendance = obj.attendance
                programThread?.activity_type_id = obj.activity_type_id
                programThread?.activity_id = obj.activity_id
                programThread?.activity_title = obj.activity_title
                programThread?.activity_date = obj.activity_date
                programThread?.abstract = obj.abstract
                programThread?.start_time = obj.start_time
                programThread?.end_time = obj.end_time
                programThread?.inactive_status = obj.inactive_status
                programThread?.day_session = obj.day_session
                programThread?.display_date = obj.display_date
                programThread?.location_id = obj.location_id
                programThread?.theme_id = obj.theme_id
                programThread?.theme_desc = obj.theme_desc
                
                
                for(_ , objCheck) in (obj.participant?.enumerated())! {
                    let particpant = NSEntityDescription.insertNewObject(forEntityName: "Participation", into: PAStorageHelper.managedObjectContext()) as! Participation

                    particpant.participant_id = objCheck.participant_id
                    particpant.participant_name = objCheck.participant_name
                    particpant.participant_photo = objCheck.participant_photo
                    particpant.designation = objCheck.designation
                    particpant.profile_desc = objCheck.profile_desc
                    particpant.role_id = objCheck.role_id
                    particpant.role_desc = objCheck.role_desc
                    particpant.gender = objCheck.gender
                    particpant.linkedin_url = objCheck.linkedin_url
                    particpant.twitter_url = objCheck.twitter_url
                    particpant.sub_designation = objCheck.sub_designation ?? " "
                    particpant.experties = objCheck.experties ?? " "
                    particpant.linkedin_url = objCheck.linkedin_url ?? " "
                    particpant.twitter_url = objCheck.twitter_url ?? " "
//                    programThread?.addToParticipantInProgram(particpant)
//                    programThread?.addToParticipantInProgram(particpant)
                    programThread?.addToParticipantInProgram(particpant)
                }
                
                programThread?.venue_id = obj.venue_id
                programThread?.venue_title = obj.venue_title
                programThread?.allow_register = obj.allow_register
                ProgramModel.save()
            }
            
            
            
        }
    }
    
    func getTheEventOfUser(){
        
        let idOfUsers = UserDefaults.standard.string(forKey: "id")
        
        let userId = idOfUsers
        let eventId = eventObj?.event_id
        let loginParam =  [ "user_id"         : "\(userId!)" ,
                            "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROGRAMTIME_WISE, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseProgramTime = response as? UserResponse
            
            if self.responseProgramTime?.success == 1 {
                
            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.responseProgramTime?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    }
    
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnGotoEvaluation()
    {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEEventEvaluationVC") as? SEEventEvaluationVC{
            vc.eventObj = eventObj
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SEEventDetailVC : UITableViewDelegate , UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        //            return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            return items.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardHeaderCell", for: indexPath) as? DashboardHeaderCell
            cell?.lblTitleOfEvent.text = eventObj?.event_title
            UserDefaults.standard.set(eventObj?.event_title , forKey: "event_title")
            let  btnEvaluation = cell?.contentView.viewWithTag(1122) as! UIButton
             btnEvaluation.addTarget(self, action: #selector(SEEventDetailVC.btnGotoEvaluation), for: .touchUpInside)
            
            return cell!

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as? DashboardCell

            let titleOfProgram = self.items[indexPath.row]
            cell?.lblTitleOfHeading.text = titleOfProgram
            let imageName = self.itemImage[indexPath.row]
            cell?.imgeOfTile?.image  = UIImage(named: imageName)
            if Connectivity.isConnectedToInternet() {
                if indexPath.row == 0 {
                    cell?.lblSubtitle.text = eventObj?.session_tagline
                } else if indexPath.row == 1 {
                    cell?.lblSubtitle.text = eventObj?.speaker_tagline
                } else {
                    let title = self.subDetail[indexPath.row - 2]
                    cell?.lblSubtitle.text = title
                }
            } else {
                if indexPath.row == 0 {
                    cell?.lblSubtitle.text = eventOffline?.session_tagline
                } else if indexPath.row == 1 {
                    cell?.lblSubtitle.text = eventOffline?.speaker_tagline
                } else {
                    let title = self.subDetail[indexPath.row - 2]
                    cell?.lblSubtitle.text = title
                }
            }
            
           
            
            
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.gotoProgram()
            } else if indexPath.row == 1 {
                self.gotoSpeaker()
            } else if indexPath.row == 2 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEMySessionVC") as? SEMySessionVC
                    vc?.programSelect = self.responseObj?.result?.programSelect
                
                self.navigationController?.pushViewController(vc!, animated: true)

            } else if indexPath.row == 3 {
                self.gotoHappening()
                
            } else if indexPath.row == 4 {
               self.gotoAskAQuestion()
            } else if indexPath.row == 5 {
                self.gotoConert(titleScreen: "CONCERT")
                
            } else if indexPath.row == 6 {
                self.gotoConert(titleScreen: "FULL STEAM")
                
            } else if indexPath.row == 7 {
                self.gotoConert(titleScreen: "MEDIA")
                
            } else if indexPath.row == 8 {
                self.gotoConert(titleScreen: "SPONSORS & EXHIBITORS")
                
            } else if indexPath.row == 10 {
                self.gotoConert(titleScreen: "SOT TEAM")
                
            }
            
//            let items = ["PROGRAMMES" , "SPEAKERS" , "MY SESSIONS" , "HAPPENINGS" ,"INFORMATION DESK" ,"CONCERT", "FULL STEAM", "MEDIA","SPONSORS & EXHIBITORS", "EVALUATION" , "SOT TEAM"]

//            SEProgramConcertVC
            

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 121.0
        }  else {
            return 80.0
        }
    }
    @objc func gotoProgram(isFromMenu : Bool = false)  {
        print ("\(isFromMenu)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEProgrammVC") as? SEProgrammVC
        
        if Connectivity.isConnectedToInternet() {
            vc?.eventObj = self.eventObj
            vc?.responseObj = self.responseObj
            vc?.isFirstDate = self.isFirstDate
            vc?.isSecondDate = self.isSecondDate
            vc?.isHall1List = self.isHall1List
            vc?.isHall2List = self.isHall2List
            vc?.isHall3List = self.isHall3List
            vc?.isHall4List = self.isHall4List
            
            
            
        } else {
            vc?.eventObjOffline = self.eventOffline
            vc?.isOfflineFirstDate = self.isOfflineFirstDate
            vc?.isOfflineSecondDate = self.isOfflineSecondDate
            
        }
        if isFromMenu{
            WAShareHelper.goToHomeController(vcIdentifier: "SEProgrammVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
        }
        else{
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    func gotoSpeaker()  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerVC") as? SESpeakerVC
        vc?.eventObj = self.eventObj
        vc?.responseObj = self.responseObj
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func gotoHappening()  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEHappeningVC") as? SEHappeningVC
        vc?.eventObj = self.eventObj
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func gotoAskAQuestion() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEAskQuestionMainVC") as? SEAskQuestionMainVC
        vc?.eventObj = eventObj
        vc?.isEventOrProgram = "Event"
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    func gotoConert(titleScreen: String)  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEProgramConcertVC") as? SEProgramConcertVC
        vc?.eventObj = eventObj
        vc?.titleOfScreen = titleScreen
        //                var titleOfEvent : String?
        //                var titleOfScreen : String?
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
