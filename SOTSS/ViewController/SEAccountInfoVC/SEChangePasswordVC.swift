//
//  SEChangePasswordVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEChangePasswordVC: UIViewController , NVActivityIndicatorViewable {
    
    @IBOutlet var txtCurrentPassword: UITextField!
    @IBOutlet var txtNewPass: UITextField!
    @IBOutlet var txtConfimPass: UITextField!

    let size = CGSize(width: 60, height: 60)
//    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBack_PRessed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnChangeBtn_Pressed(_ sender: UIButton) {
        let fistName = UserDefaults.standard.string(forKey: "first_name")
        let lastName = UserDefaults.standard.string(forKey: "last_name")
        let email = UserDefaults.standard.string(forKey: "email")
        let phone = UserDefaults.standard.string(forKey: "phone")
        let idOfUsers = UserDefaults.standard.string(forKey: "id")

        let loginParam = [ "user_id"             :  idOfUsers!,
                           "current_password"    :  txtCurrentPassword.text! ,
                           "new_password"        :  txtNewPass.text!
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: CHANGEPASSWORD_EVENT, isLoaderShow: true , serviceType: "Change Password", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()

            let responseObj = response as! UserResponse
          
            if responseObj.success == 1 {
                
                self.showAlert(title: "SOT Event", message: (responseObj.message!), controller: self)

            }else {
                self.showAlert(title: "SOT Event", message: (responseObj.message!), controller: self)

                //                self .showAlert(title: "Mobinp", message: responseObj.message! , controller: self)
            }
            
            
        }, fail: { (error) in
            
            
                        self.showAlert(title: "SOT Event", message: error.description , controller: self)
        }, showHUD: true)
        
    }

   

}
