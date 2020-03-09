//
//  SELoginVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import DatePickerDialog
import GoogleSignIn


class SELoginVC: UIViewController   , NVActivityIndicatorViewable ,  GIDSignInUIDelegate , GIDSignInDelegate {
    
    @IBOutlet var mainView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    let size = CGSize(width: 60, height: 60)
    var cover_image: UIImageView?
    
    @IBOutlet weak var imgOfBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        mainView.setContentOffset(CGPoint(x: 0, y:20), animated: false)
        txtEmail.setLeftPaddingPoints(5)
        txtPass.setLeftPaddingPoints(5)
        let idOfUser = UserDefaults.standard.integer(forKey: "id")
//        let idOfUsers = UserDefaults.standard.string(forKey: "id")

        if idOfUser == 0  {

        } else {
            WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")

        }

//        txtEmail.text = "ahmadyarimran@yahoo.com"
//        txtPass.text  = "123456789"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    
    @IBAction func btnSignIn_Pressed(_ sender: UIButton) {
      
        if txtEmail?.text?.count == 0 {
            self.showAlert(title: "SOT Event", message: "Please enter email.", controller: self)
            return
        }
        
        if txtPass.text?.count == 0 {
            self.showAlert(title: "SOT Event", message: "Please enter password.", controller: self)
            return
        }
        let loginParam =  [ "email"         : txtEmail.text!,
                            "password"       : txtPass.text!

                          ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)


        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            
            let responseObj = response as! UserResponse
            
//
            if responseObj.success == 1 {
                
                
                localUserData = responseObj.result?.userInfo
                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
                UserDefaults.standard.set(localUserData.user_id , forKey: "id")
                UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
                UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
                UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
                UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
                UserDefaults.standard.set(localUserData.phone , forKey: "phone")
                UserDefaults.standard.set(localUserData.image , forKey: "image")
                UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
                UserDefaults.standard.set(localUserData.gender , forKey: "gender")
                let updateTokenParam =  [ "user_id"           : localUserData.user_id!,
                                    "manufacture"       : "iOS" ,
                                    "token"             : DEVICE_TOKEN,
                                    "manufacturer"      : "Apple" ,
                                    "model"             : "Apple" ,
                                    "platform"          : "iOS" ,
                                    "serial"            : "no serial" ,
                                    "uuid"              : "iOS_id" ,
                                    "version"           : "12.0" ,
                                    "status"            : "A"
                    
                    ] as [String : Any]
                
                
                WebServiceManager.post(params: updateTokenParam as Dictionary<String, AnyObject> , serviceName: INSERTUSERDEVICE, isLoaderShow: false, serviceType: "insert_user_device", modelType:  UserResponse.self, success: { (response) in
                    self.stopAnimating()

                    if responseObj.success == 1 {
                        WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")

                    } else {
                        self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                    }

                    
                }, fail: { (error) in
                    
                }, showHUD: true)
            }
            else
            {
                self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                self.stopAnimating()

            }


        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()

        }, showHUD: true)
        

    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnFacebook_Pressed(_ sender: UIButton) {
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
                    
                    localUserData = responseObj.result?.userInfo
                    UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                    UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
                    UserDefaults.standard.set(localUserData.user_id , forKey: "id")
                    UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
                    UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
                    UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
                    UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
                    UserDefaults.standard.set(localUserData.phone , forKey: "phone")
                    UserDefaults.standard.set(localUserData.image , forKey: "image")
                    UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
                    UserDefaults.standard.set(localUserData.gender , forKey: "gender")

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
    
//        WAShareHelper.loadImage(urlstring:userImage! , imageView: (self.userImage)!, placeHolder: "logo_grey")

//
//        ["email"                    :  txtEmail.text!  ,
//         "password"                 :  txtPass.text! ,
//         "first_name"               :  txtFirstName.text! ,
//         "last_name"                :  txtLastName.text!,
//         "phone"                    :  txtMobileNumber.text! ,
//         "gender"                   :  "M",
//         "date_of_birth"            :  "01/09/2017"

    
    
    
    @IBAction func btnGooglePlus_Pressed(_ sender: UIButton) {
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
                        vc?.getTheAgeGroup()
                        self.navigationController?.pushViewController(vc!, animated: true)
                    } else {
                        localUserData = responseObj.result?.userInfo
                        UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                        UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
                        UserDefaults.standard.set(localUserData.user_id , forKey: "id")
                        UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
                        UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
                        UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
                        UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
                        UserDefaults.standard.set(localUserData.phone , forKey: "phone")
                        UserDefaults.standard.set(localUserData.image , forKey: "image")
                        UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
                        UserDefaults.standard.set(localUserData.gender , forKey: "gender")
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

    
    @IBAction func btnForgot_Password_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEForgotPasswordVC") as? SEForgotPasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func btnCreateAccount_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESignUpVC") as? SESignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnTermAndConditon_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SETermConditionVC") as? SETermConditionVC
        self.navigationController?.pushViewController(vc!, animated: true)

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

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
