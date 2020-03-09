//
//  SEAboutVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 09/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEAboutVC: UIViewController , NVActivityIndicatorViewable {
    let size = CGSize(width: 60, height: 60)
    var aboutResponse : UserResponse?

    @IBOutlet weak var imgOfUser: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    
    @IBOutlet weak var txtOfAbout: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTheAbout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
    
    func getTheAbout(){
        
    
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let idOfUser = UserDefaults.standard.integer(forKey: "id")

        let loginParam =  [ "user_id"        :  "\(idOfUser)"
            
            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: ABOUT_API, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.aboutResponse = response as? UserResponse
            
            if self.aboutResponse?.success == 1 {
//                @IBOutlet weak var imgOfUser: UIImageView!
//
//                @IBOutlet weak var lblName: UILabel!
//                @IBOutlet weak var lblDesignation: UILabel!
//
//                @IBOutlet weak var txtOfAbout: UITextView!
                
                WAShareHelper.loadImage(urlstring: (self.aboutResponse?.aboutResult?.picture)! , imageView: (self.imgOfUser)!, placeHolder: "rectangle_placeholder")
                self.lblName.text = self.aboutResponse?.aboutResult?.name
                self.lblDesignation.text = self.aboutResponse?.aboutResult?.desig
                
                let desc1 = self.aboutResponse?.aboutResult?.desc_1
                let desc2 = self.aboutResponse?.aboutResult?.desc_2
                let desc3 = self.aboutResponse?.aboutResult?.desc_3
                let desc4 = self.aboutResponse?.aboutResult?.desc_4
                

                self.txtOfAbout.text =  "\(desc1!) \n \(desc2!) \n \(desc3!) \n \(desc4!)"


            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.aboutResponse?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    }

}
