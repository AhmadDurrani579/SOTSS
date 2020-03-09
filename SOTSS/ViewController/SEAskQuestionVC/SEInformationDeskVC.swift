//
//  SEInformationDeskVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEInformationDeskVC: UIViewController , NVActivityIndicatorViewable {
    var index: Int?
    @IBOutlet weak var lblTitleOfProgram: UILabel!
    var eventObj : EventObject?
    var programObject : ProgramsObject?
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    var isEventOrProgram : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleOfProgram.text = eventObj?.event_title
        getTheInfoDesk()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTheInfoDesk() {
        
        let eventId = eventObj?.event_id
        let loginParam =  [ "event_id"         : "\(eventId!)"

            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: INFODESK, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            if self.responseObj?.success == 1 {
//                self.showAlert(title: "SOT Events", message: (self.responseObj?.message!)!, controller: self)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
