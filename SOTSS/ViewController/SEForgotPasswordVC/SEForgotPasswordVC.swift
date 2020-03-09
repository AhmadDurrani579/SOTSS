//
//  SEForgotPasswordVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEForgotPasswordVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var txtEmail: UITextField!
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(10)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
        if !(txtEmail.text!.count > 0) {
         
            self.showAlert(title: "SOT Event", message: "Please enter email", controller: self)
            return
        }
        
        let loginParam =  [ "email"         : txtEmail.text!
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: FORGOTPASSWORD, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            let responseObj = response as! UserResponse
            if responseObj.success == 1 {
                self.showAlertViewWithTitle(title: "SOT Admin", message: responseObj.message!, dismissCompletion: {
                    self.navigationController?.popViewController(animated: true)
                })
                
            }
            else
            {
                self.showAlert(title: "SOT Admin", message: responseObj.message!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Admin", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
    }


    @IBAction func btnBack_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        
    }
}
