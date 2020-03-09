//
//  SESessionDetailVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SESessionDetailVC: UIViewController , NVActivityIndicatorViewable{
    @IBOutlet var tblView: UITableView!
    
    var programObject : ProgramsObject?
    var programModel : ProgramModel?
    var eventOffline : EventModel?
    var isReadMorePressed : Bool?
    var eventObj : EventObject?
    var responseObj: UserResponse?
    var participant : [Participation]?
    let size = CGSize(width: 60, height: 60)

    @IBOutlet weak var lblDate: UILabel!

    var isRegisterOrUnRegister : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "ParticipationListCell", bundle: nil), forCellReuseIdentifier: "ParticipationListCell")
        
        if  Connectivity.isConnectedToInternet() {
            lblDate.text = eventObj?.event_title

        } else {
            lblDate.text = eventOffline?.event_title
            participant = programModel?.participantInProgram?.allObjects as? [Participation]

        }

        isReadMorePressed = false
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadDataWithAutoSizingCellWorkAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
}

extension SESessionDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            if Connectivity.isConnectedToInternet() {
                return (programObject?.participant?.count)!

            } else {
                return (participant?.count)!
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionDetailCell", for: indexPath) as? SessionDetailCell
//            cell?.lblDisplayDate.text = self.eventObj?.eventDate![indexPath.row].event_display_date
            if Connectivity.isConnectedToInternet() {
                
                if isRegisterOrUnRegister == "register" {
                    cell?.btnRegister.isHidden = false
                    cell?.btnUnRegister.isHidden = true

                } else {
                    cell?.btnRegister.isHidden = true
                    cell?.btnUnRegister.isHidden = false
                }
                cell?.lblActivity_title.text = programObject?.activity_title
                cell?.lblActivity_desc.text = programObject?.activity_desc
                cell?.lblDisplay_date.text = programObject?.display_date
                cell?.lblVenue_title.text = programObject?.venue_title
                cell?.lblDetail.text = programObject?.abstract
                cell?.delegae = self
                cell?.index = indexPath
            } else {
                cell?.lblActivity_title.text = programModel?.activity_title
                cell?.lblActivity_desc.text = programModel?.activity_desc
                cell?.lblDisplay_date.text = programModel?.display_date
                cell?.lblVenue_title.text = programModel?.venue_title
                cell?.lblDetail.text = programModel?.abstract
                cell?.delegae = self
                cell?.index = indexPath
            }
           

            return cell!
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipationListCell", for: indexPath) as? ParticipationListCell
            if Connectivity.isConnectedToInternet() {
                WAShareHelper.loadImage(urlstring: (programObject?.participant![indexPath.row].participant_photo)! , imageView: (cell?.imgOfUser)!, placeHolder: "rectangle_placeholder")
                cell?.lblNameOfParticipant.text = programObject?.participant![indexPath.row].participant_name
                cell?.lblDesignation.text = programObject?.participant![indexPath.row].designation
            } else {
                WAShareHelper.loadImage(urlstring: (participant![indexPath.row].participant_photo)! , imageView: (cell?.imgOfUser)!, placeHolder: "rectangle_placeholder")
                cell?.lblNameOfParticipant.text = participant![indexPath.row].participant_name
                cell?.lblDesignation.text = participant![indexPath.row].designation
            }
            
            return cell!
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerProfile") as? SESpeakerProfile
            if Connectivity.isConnectedToInternet() {
                vc?.responseObj = self.responseObj
                vc?.participant = self.programObject?.participant![indexPath.row]
                vc?.eventObj = self.eventObj

            } else {
                vc?.participantOffline = self.participant![indexPath.row]
                vc?.eventOffline = self.eventOffline
                
            }
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if isReadMorePressed == true {
               return UITableViewAutomaticDimension
            } else {
                return 279.0
            }
        }  else {
            return 62.0
        }
    }
    
}

extension SESessionDetailVC : ReadMore {
    
    func readMoreButtonPressed(cell : SessionDetailCell , index : IndexPath) {
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
    
    func AskQuestion(cell: SessionDetailCell, index: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEAskQuestionMainVC") as? SEAskQuestionMainVC
        vc?.eventObj = eventObj
        vc?.programObject = programObject
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func evaluationOfProgram(cell: SessionDetailCell, index: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEEvaluationVC") as? SEEvaluationVC
        vc?.eventObj = eventObj
        vc?.programObject = programObject
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func PollOfProgram(cell: SessionDetailCell, index: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEPOllVC") as? SEPOllVC
        vc?.eventObj = eventObj
        vc?.programObject = programObject
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    func registerUserForProgram(cell: SessionDetailCell, indexCheck: IndexPath) {
        //
        let idOfUser = UserDefaults.standard.integer(forKey: "id")
        let schedule_id = programObject?.schedule_id
        let activity_date = programModel?.activity_date
        let loginParam =  [ "user_id"            : "\(idOfUser)" ,
                            "schedule_id"        :  schedule_id! ,
                            "activity_date"      : activity_date!
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: REGISTERUSERPROGRAM, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            let  responseObj = response as? UserResponse
            if responseObj?.success == 1 {
                self.showAlertViewWithTitle(title: "SOT Event" , message: (responseObj?.message!)!, dismissCompletion: {
                    cell.btnRegister.isHidden = true
                    cell.btnUnRegister.isHidden = false
                    
                })
            }
                
            else
            {
                self.showAlert(title: "SOT Event", message: (responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
        
    }
    
    func UnRegisterUserForProgram(cell: SessionDetailCell, indexCheck: IndexPath) {
        //
        let idOfUser = UserDefaults.standard.integer(forKey: "id")
        let schedule_id = programObject?.schedule_id
        
        
        let loginParam =  [ "user_id"            : "\(idOfUser)" ,
            "schedule_id"        :  schedule_id!
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: UNREGISTERPROGRAM, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            let  responseObj = response as? UserResponse
            if responseObj?.success == 1 {
                self.showAlertViewWithTitle(title: "SOT Event" , message: (responseObj?.message!)!, dismissCompletion: {
                    cell.btnRegister.isHidden = false
                    cell.btnUnRegister.isHidden = true
                    self.tblView.reloadData()
                    
                    
                })
                
                self.showAlert(title: "SOT Event", message: (responseObj?.message!)!, controller: self)
            }
                
            else
            {
                self.showAlert(title: "SOT Event", message: (responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
        
    }


}


extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.characters.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.characters.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}
