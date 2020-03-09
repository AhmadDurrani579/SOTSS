//
//  SESignUpVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import DatePickerDialog
import NVActivityIndicatorView
import ActionSheetPicker_3_0

class SESignUpVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var btnChooseDate: UIButton!
    @IBOutlet weak var btnChosseAssociation: UIButton!
    
    var serviceUrl : String?
    var userId : String?
    
    
    var email : String?
    var firstName : String?
    var lastName : String?
    var isSocialId : String?
    var isLoginWithSocial : String?
    
    var isImageCheck : UIImage?
    
    
    @IBOutlet weak var txtExplain: UITextField!

    @IBOutlet var profilePic: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?

    @IBOutlet weak var btnMale: KGRadioButton!
    @IBOutlet weak var btnFemale: KGRadioButton!
    @IBOutlet weak var btnOther: KGRadioButton!
    var isMaleFemaleOtherSelect : String? = ""
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    
    @IBOutlet weak var btnIsAssociation: KGRadioButton!
    @IBOutlet weak var btnIsNotAssociation: KGRadioButton!
    
    
    @IBOutlet weak var viewOfNaatureOfAssociation: UIView!
    @IBOutlet weak var viewOfNatureOfExplain : UIView!

    @IBOutlet weak var heightOfNatureAssociation: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfPleaseExplain: NSLayoutConstraint!
    
    var isAssociation : String?
    var isAssociationID : String?
    var other_association : String?
    var groupId         : String?
    
    var isLoginWith : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        viewOfNaatureOfAssociation.isHidden = true
        viewOfNatureOfExplain.isHidden = true
        heightOfNatureAssociation.constant = 0.0
        heightOfPleaseExplain.constant = 0.0
        setUpUI()
        getTheAgeGroup()

        if isLoginWithSocial == "f" || isLoginWithSocial == "g" {
            txtEmail.text = email
            txtFirstName.text = firstName
            txtLastName.text = lastName
            guard let  checkImge =  isImageCheck else {
                return profilePic.image = UIImage(named: "userProfile")
            }
            profilePic.image = checkImge
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
       
        txtEmail.setLeftPaddingPoints(10)
        txtPass.setLeftPaddingPoints(10)
        txtFirstName.setLeftPaddingPoints(10)
        txtLastName.setLeftPaddingPoints(10)
        txtMobileNumber.setLeftPaddingPoints(10)
        txtConfirmPass.setLeftPaddingPoints(10)

        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(SESignUpVC.imageTappedForDp(img:)))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizerforDp)
    }

    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 1970
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        
//        01/09/2017
        datePicker.show("DatePickerDialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd-MM-yyyy"
                                let dateValue = formatter.string(from: dt)
                                self.btnChooseDate.setTitle(dateValue, for: .normal)
                                
                }
        }
    }

    
    
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.profilePic.image = orignal
            let cgFloat: CGFloat = self.profilePic.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.profilePic, radius: CGFloat(someFloat))
            self.cover_image = orignal
        }
    }
    
    @IBAction func btnChoseDate_Pressed(_ sender: UIButton) {
//        datePickerTapped()
        
        var allRole = [String]()
        for (_ , info) in (self.responseObj?.result?.ageGroup?.enumerated())! {
            allRole.append(info.age_group!)
        }
        ActionSheetStringPicker.show(withTitle: "Select Age Group", rows: allRole , initialSelection: 0 , doneBlock: { (picker, index, value) in
            
            let category = self.responseObj?.result?.ageGroup![index]
            self.btnChooseDate.setTitle(category?.age_group , for: .normal)
            //            self.idOfUniversity = category?.id
            
            self.groupId = category?.age_group_id

            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)

        
    }
    
    @IBAction func btnChoseAssosiation_Pressed(_ sender: UIButton) {
        //        datePickerTapped()
        
        var allRole = [String]()
        for (_ , info) in (self.responseObj?.result?.associationObj?.enumerated())! {
            allRole.append(info.association_name!)
        }
        ActionSheetStringPicker.show(withTitle: "Select Nature Of Association", rows: allRole , initialSelection: 0 , doneBlock: { (picker, index, value) in
            
            let category = self.responseObj?.result?.associationObj![index]
            self.btnChosseAssociation.setTitle(category?.association_name , for: .normal)
            
            self.isAssociationID = category?.association_id
            
//            isAssociationID = ""
//            other_association = ""

            if category?.association_id == "999" {
                self.viewOfNatureOfExplain.isHidden = false
                self.heightOfPleaseExplain.constant = 50.0
                

            } else {
                self.viewOfNatureOfExplain.isHidden = true
                self.heightOfPleaseExplain.constant = 0.0
                self.other_association = ""

            }
            print("values = \(value!)")
            print("indexes = \(index)")
            print("picker = \(picker!)")
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)
        
        
    }

    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func validate() -> (Bool) {
        
        
        if txtEmail?.text?.count == 0 {
           return false
        }
        
        else if txtPass.text?.count == 0 {
            return false
        }
        else if txtConfirmPass.text?.count == 0 {
            return false
        }
        else if txtFirstName.text?.count == 0 {
            return false
        }
        else if txtLastName.text?.count == 0 {
            return false
        }
        else if txtMobileNumber.text?.count == 0 {
            return false
        }
        else if isMaleFemaleOtherSelect?.count == 0 {
            return false
        }
        else if groupId?.count == 0 {
            return false
        }
        
        return true
    }
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        
        let v = validate()
        if !v{
            self.showAlert(title: "SOT Event", message: "All fields are mandatory marked with (*)", controller: self)
            return
        }
        if  txtMobileNumber.text!.count  > 15 {
            self.showAlert(title: "SOT Event", message: "Mobile number too long", controller: self)
            return
        }
        if !txtEmail.text!.contains("@"){
            self.showAlert(title: "SOT Event", message: "Invalid Email", controller: self)
            return
        }
        self.other_association = self.txtExplain.text!
        
        let param : [String : Any]
        
        if isLoginWithSocial == "f" || isLoginWithSocial == "g" {
            
            param = ["email"                    :  txtEmail.text!  ,
                     "password"                 :  txtPass.text! ,
                     "first_name"               :  txtFirstName.text! ,
                     "last_name"                :  txtLastName.text!,
                     "phone"                    :  txtMobileNumber.text! ,
                     "gender"                   :  isMaleFemaleOtherSelect! ,
                     "is_associate"             :  isAssociation! ,
                     "association_id"           :  isAssociationID! ,
                     "other_association"        :  self.other_association! ,
                     "age_group_id"             :  groupId! ,
                      "login_with"              :  isLoginWith! ,
                     "user_id"                  :  userId! ,
                     "profile_update_status"    : "Y"
            ]
        } else {
            param =    ["email"                    :  txtEmail.text!  ,
             "password"                 :  txtPass.text! ,
             "first_name"               :  txtFirstName.text! ,
             "last_name"                :  txtLastName.text!,
             "phone"                    :  txtMobileNumber.text! ,
             "gender"                   :  isMaleFemaleOtherSelect! ,
             "is_associate"             :  isAssociation! ,
             "association_id"           :  isAssociationID! ,
             "other_association"        :  self.other_association! ,
             "age_group_id"             :  groupId! ,
             "login_!with"               :  isLoginWith!
            ]
        }
        
        WebServiceManager.multiPartImage(params: param as Dictionary<String, AnyObject> , serviceName: serviceUrl!, imageParam:"image.png", serviceType: "Sign Up", profileImage: profilePic.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
            
            
            let responseObj = response as! UserResponse
            
            
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

                self.showAlertViewWithTitle(title: "SOT Event", message: responseObj.message! ,isCancelButtonShow: false, dismissCompletion: {
                    WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")

                })
                
               
            }
            else
            {
                self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                
            }
            
        }) { (error) in
            
            
        }
    }

    
    @IBAction func btnMale_Pressed(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnMale.isSelected = true
        btnFemale.isSelected = false
        btnOther.isSelected = false
        isMaleFemaleOtherSelect = "Male"
    }
    
    @IBAction func btnIsAssociation_Pressed(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnIsNotAssociation.isSelected = false
        btnIsAssociation.isSelected = true
        //            var isAssociation : String?
        //            var isAssociationID : String?
        //            var other_association : String?
        //            var groupId         : String?
        
        isAssociation = "Y"
        viewOfNaatureOfAssociation.isHidden = false
        heightOfNatureAssociation.constant = 50.0

    }
    
    @IBAction func btnOtherSelect(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnIsNotAssociation.isSelected = true
        btnIsAssociation.isSelected = false
        isAssociation = "N"
        isAssociationID = ""
        other_association = ""

        viewOfNaatureOfAssociation.isHidden = true
        heightOfNatureAssociation.constant = 0.0


    }

    @IBAction func btnFemale_Pressed(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnMale.isSelected = false
        btnFemale.isSelected = true
        btnOther.isSelected = false
        isMaleFemaleOtherSelect = "Female"
    }
    @IBAction func btnOther_Pressed(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        btnMale.isSelected = false
        btnFemale.isSelected = false
        btnOther.isSelected = true
        isMaleFemaleOtherSelect = "Other"

    }
    
   // Age Group Api
    
    func getTheAgeGroup() {
       
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let loginParam =  [ "email"         : ""
                            
            
            ] as [String : Any]

        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SIGNUPSETTING, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()

            self.responseObj = response as? UserResponse
            
            //
            if self.responseObj?.success == 1 {
                
//                localUserData = responseObj.result?.userInfo
            }
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)

        
    }
}
