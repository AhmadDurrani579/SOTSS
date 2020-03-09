//
//  SEAskQuestionVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEAskQuestionVC: UIViewController , NVActivityIndicatorViewable {
    var index: Int?
    @IBOutlet weak var lblTitle: UILabel!
    var eventObj : EventObject?
    @IBOutlet weak var lblProgramTitle: UILabel!
    
    @IBOutlet weak var txtWriteYourQuestion: UITextView!
    var programObject : ProgramsObject?
  
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    var isEventOrProgram : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = eventObj?.event_title
        
        if isEventOrProgram == "Event" {
            lblProgramTitle.text = eventObj?.event_category
        } else {
            lblProgramTitle.text =  programObject?.activity_title

        }
        txtWriteYourQuestion.placeholder = "Please write your question"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
        
        let userId = eventObj?.event_id
        let loginParam =  [ "event_id"         : "\(userId!)" ,
                            "question_title"   : lblProgramTitle.text! ,
                            "question_detail"  : txtWriteYourQuestion.text!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: ASKQUESTION, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            if self.responseObj?.success == 1 {
                self.showAlert(title: "SOT Events", message: (self.responseObj?.message!)!, controller: self)
//                self.showAlertViewWithTitle(title: "SOT Events", message: (self.responseObj?.message!)!, dismissCompletion: {
//                    self.navigationController?.popViewController(animated: true)
//                })
//                txtWriteYourQuestion.placeholder = "Please write your question"

            }
            else
            {
                self.showAlert(title: "SOT Event", message: "Please enter a question", controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
