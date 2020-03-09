//
//  SEQRCodeVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEQRCodeVC: UIViewController {
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmailOFUser: UILabel!
    @IBOutlet weak var imgOfQRCode: UIImageView!
    @IBOutlet weak var lblUserID: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fistName = UserDefaults.standard.string(forKey: "first_name")
        let lastName = UserDefaults.standard.string(forKey: "last_name")
        let email = UserDefaults.standard.string(forKey: "email")
        let phone = UserDefaults.standard.string(forKey: "phone")
        let idOfUsers = UserDefaults.standard.string(forKey: "id")
        let qrCode = UserDefaults.standard.string(forKey: "qrcode")
        let imgOFUser = UserDefaults.standard.string(forKey: "image")


        //                UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")

        lblUserName.text = "\(fistName!) \(lastName!)"
//        lblUserID.text = localUserData.user_id
        
//        let userID = localUserData.user_id
        
        lblUserID.text = "User ID :   \(idOfUsers!)"
        lblEmailOFUser.text = email
        //                UserDefaults.standard.set(localUserData.image , forKey: "image")

        let qrImage = qrCode
        if qrImage != nil {
            WAShareHelper.loadImage(urlstring: qrImage! , imageView: imgOfQRCode!, placeHolder: "userProfile")
        }
        
        guard let imge = imgOFUser else {
            return
        }
        WAShareHelper.loadImage(urlstring: imge , imageView: imgOfUser!, placeHolder: "userProfile")
        
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
    
   
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        if appDelegate.isSideMenu == true {
            self.revealController.show(self.revealController.leftViewController)

        } else {
            self.navigationController?.popViewController(animated: true)

        }
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
