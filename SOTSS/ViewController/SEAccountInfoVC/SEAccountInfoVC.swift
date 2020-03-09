//
//  SEAccountInfoVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEAccountInfoVC: UIViewController {

    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserId: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userImage = localUserData.image
        //                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
        //                UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
        //                UserDefaults.standard.set(localUserData.user_id , forKey: "id")
        //                UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
        //                UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
        //                UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
        //                UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
        //                UserDefaults.standard.set(localUserData.phone , forKey: "phone")
        //                UserDefaults.standard.set(localUserData.image , forKey: "image")
        //                UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
        //                UserDefaults.standard.set(localUserData.gender , forKey: "gender")
        
        
        let idOfUsers = UserDefaults.standard.string(forKey: "id")

//        let idOfUser = UserDefaults.standard.integer(forKey: "id")
        let fistName = UserDefaults.standard.string(forKey: "first_name")
        let lastName = UserDefaults.standard.string(forKey: "last_name")
        let email = UserDefaults.standard.string(forKey: "email")
        let phone = UserDefaults.standard.string(forKey: "phone")
        let imageOfUser = UserDefaults.standard.string(forKey: "image")

         lblUserName.text = "\(fistName!) \(lastName!)"

//        lblUserName.text = localUserData.first_name
        lblUserId.text = idOfUsers
        lblEmail.text = email
        lblMobile.text = phone
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(SEAccountInfoVC.imageTappedForDp(img:)))
        imgOfUser.isUserInteractionEnabled = true
        imgOfUser.addGestureRecognizer(tapGestureRecognizerforDp)
        
        guard let imge = imageOfUser else {
            return
        }
        WAShareHelper.loadImage(urlstring: imge , imageView: imgOfUser!, placeHolder: "rectangle_placeholder")

        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.imgOfUser.image = orignal
            let cgFloat: CGFloat = self.imgOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.imgOfUser, radius: CGFloat(someFloat))
            self.cover_image = orignal
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        
         self.revealController.show(self.revealController.leftViewController)
    }
    
    @IBAction func btnMyNetwork_Pressed(_ sender: UIButton) {
        
    }
    @IBAction func btnEditProfile_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnContribution_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnQRCode_Pressed(_ sender: UIButton) {
        appDelegate.isSideMenu = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEQRCodeVC") as? SEQRCodeVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnSettings_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnChangePAssword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEChangePasswordVC") as? SEChangePasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
