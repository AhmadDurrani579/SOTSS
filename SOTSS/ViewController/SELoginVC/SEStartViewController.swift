//
//  SEStartViewController.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 20/10/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import GoogleSignIn

class SEStartViewController: UIViewController , NVActivityIndicatorViewable , GIDSignInUIDelegate , GIDSignInDelegate {
    let size = CGSize(width: 60, height: 60)
    var cover_image: UIImageView?
    
    @IBOutlet weak var imgOfBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self


        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack_pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSign_PRessedWithGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()

    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        }
        else {
            
            startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
            let param =      ["email"                     :  user.profile.email!  ,
                              "login_with"                : "Google"
                ] as [String : Any]
            
            WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SIGNUP, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
                self.stopAnimating()
                
                let responseObj = response as! UserResponse
                localUserData = responseObj.result?.userInfo
                
                UserDefaults.standard.set(user.profile.email! , forKey: "email")
                UserDefaults.standard.set(localUserData.user_id , forKey: "id")
                UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
                UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
                UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
                UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
                UserDefaults.standard.set(localUserData.phone , forKey: "phone")
                UserDefaults.standard.set(localUserData.image , forKey: "image")
                UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
                UserDefaults.standard.set(localUserData.gender , forKey: "gender")
                
                if responseObj.success == 1 {
                    if responseObj.result?.userInfo?.profile_update_status == "N" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESignUpVC") as? SESignUpVC
                        vc?.isLoginWithSocial = "g"
                        vc?.email = user.profile.email
                        vc?.firstName = user.profile.name
                        vc?.lastName = user.profile.givenName
                        vc?.isImageCheck = self.imgOfBackground.image
                        vc?.isLoginWith = "google"
                        vc?.serviceUrl = COMPLETEPROFILE
                        vc?.userId = responseObj.result?.userInfo?.user_id
                        self.navigationController?.pushViewController(vc!, animated: true)
                    } else {
                        WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")
                        
                    }
                    
                    
                }
                else
                {
                    self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                    
                }
                
                
            }, fail: { (error) in
                self.showAlert(title: "SOT Event", message:error.description  , controller: self)
                self.stopAnimating()
                
            }, showHUD: true)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print("Some Error ")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }

    
    @IBAction func btnSign_PRessedWithFacebook(_ sender: UIButton) {
        let facebookMangager = SocialMediaManager()
        facebookMangager.facebookSignup(self)
        facebookMangager.successBlock = { (response) -> Void in
            self.signupWebservice(response as! Dictionary)
        }
    }

    func signupWebservice(_ params: Dictionary<String, String>) {
        
        
        let email : String?
        let idOfFb : String?
        let firstName : String?
        let lastName  : String?
        let gender  : String?
        let phonenumber : String?
        let deviceType  : String?
        let deviceToken : String?
        let image : String?
        email       =     params["data[User][email]"]
        image       =     params["data[User][picture]"]
        
        idOfFb      =     params["data[User][facebook_id]"]
        firstName   =     params["data[User][first_name]"]
        lastName    =     params["data[User][last_name]"]
        deviceType  =     params["data[Device][device_type]"]
        
        
        WAShareHelper.loadImage(urlstring: (image)! , imageView: (imgOfBackground)!, placeHolder: "rectangle_placeholder")
        
        let param =      ["email"                     :  email!  ,
                          "login_with"                : "Facebook"
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SIGNUP, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            let responseObj = response as! UserResponse
            
            localUserData = responseObj.result?.userInfo
            UserDefaults.standard.set(email! , forKey: "email")
            UserDefaults.standard.set(localUserData.user_id , forKey: "id")
            UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
            UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
            UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
            UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
            UserDefaults.standard.set(localUserData.phone , forKey: "phone")
            UserDefaults.standard.set(localUserData.image , forKey: "image")
            UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
            UserDefaults.standard.set(localUserData.gender , forKey: "gender")
            
            if responseObj.success == 1 {
                if responseObj.result?.userInfo?.profile_update_status == "N" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESignUpVC") as? SESignUpVC
                    vc?.isLoginWithSocial = "f"
                    vc?.email = email
                    vc?.firstName = firstName
                    vc?.lastName = lastName
                    vc?.isSocialId = idOfFb
                    vc?.isImageCheck = self.imgOfBackground.image
                    vc?.isLoginWith = "facebook"
                    vc?.serviceUrl = COMPLETEPROFILE
                    vc?.userId = responseObj.result?.userInfo?.user_id
                    
                    self.navigationController?.pushViewController(vc!, animated: true)
                } else {
                    WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")
                    
                }
                
                
            }
            else
            {
                self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Event", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        //        01/09/2017
        
    }

    
    @IBAction func btnSign_UpPressedWithEmail(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESignUpVC") as? SESignUpVC
        vc?.isLoginWith = "email"
        vc?.serviceUrl = SIGNUP
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    

}
