//
//  ZGConstants.swift
//  ZoGoo
//
//  Created by Salman Nasir on 20/02/2017.
//  Copyright © 2017 Salman Nasir. All rights reserved.
//

import UIKit


struct ProductionServerURL {
  static  let BASE_URL  =  "http://54.67.76.104/"

}

  struct setBoarder {
    let view : UIView?
    let width : CGFloat?
    let color : UIColor?
    
    @discardableResult  init(view: UIView, width: CGFloat , color : UIColor ) {
        self.view = view
        self.width  = width
        self.color  = color
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
        
        

    }
}

enum WAUserType : Int
{
    case WAUser = 0 ,
    WAVendor
    
}

enum TQActionType: Int {
    case TQLogin = 0,
    TQSignup,
    TQForgetPassword ,
    TQSkip
}



var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  0.0
var DEVICE_LONG = 0.0
var DEVICE_ADDRESS = ""
var SELECTUSER = ""



let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)

//LIVE URL


let BASE_URL  =  "https://ws.beams.beaconhouse.net/sot/sotevents/index.php/api/"


let BASE_URLFORTHECONTESTANTImage  =  "http://adadigbomma.com/panel/images/contestant/"
let BASE_URLFOR_GALLERY_Image  =  "http://adadigbomma.com/panel/images/gallery/"
let BASE_URLFOR_NEWImage  =  "http://adadigbomma.com/panel/images/"



//let BASE_URL  =  "http://adadigbomma.com/"

//LOCAL URL
//let BASE_URL = "http://192.168.1.192/whereapp/api/"


//let API_KEY = "jIbF3yQG0s/AliunDtw3yYfH5w1mzOk5MaTeXIU5ORI="

//service URLS
let VERIFY_CODE = BASE_URL + "Signup/CheckCode"
//let SIGNUP = BASE_URL + "user/register"
let RESET_PASSWORD = BASE_URL + "Signup/Resetpassword"



let SIGNUP = BASE_URL + "signup"
let FORGOTPASSWORD = BASE_URL + "forget_password"
let LOGIN = BASE_URL + "user_login"
let SIGNUPSETTING = BASE_URL + "signup_settings"
let COMPLETEPROFILE = BASE_URL + "complete_profile"



let EVENTAPI = BASE_URL + "events"
let PROGRAMTIME_WISE = BASE_URL + "programs_timewise"
let PROGRAME = BASE_URL + "programs"
let SPEAKER_LIST = BASE_URL + "event_participants"
let CHANGEPASSWORD_EVENT = BASE_URL + "change_password"
let ABOUT_API = BASE_URL + "about_us"
let ASKQUESTION = BASE_URL + "event_ask_question"
let INFODESK = BASE_URL + "info_desk"
let EVENTFAQ = BASE_URL + "event_faqs"
let HAPPENINGAPI = BASE_URL + "happenings"
let USERMESSAGESLIST = BASE_URL + "user_messages"
let REGISTERUSERPROGRAM = BASE_URL + "register_user_program"
let UNREGISTERPROGRAM = BASE_URL + "unregister_user_program"









let LOGINAUTH = BASE_URL + "user/pre-auth"
let GETALLEVENT = BASE_URL + "App/events"
let EVENTDETAIL = BASE_URL + "App/eventDetail"
let TICKETBOOKING = BASE_URL + "App/bookEvent"
let BLOGLIST = BASE_URL + "App/blog"
let EVENTVIEVED = BASE_URL + "App/eventViewed"
let APPLYFILTER = BASE_URL + "App/searchFilter"




let GETALLBAR = BASE_URL + "App/getAllBars"
let GETALLBARIMAGES = BASE_URL + "App/clubimages"
let GETALLBARVIDEO = BASE_URL + "App/clubvideos"
let GETALLFAVOURITE = BASE_URL + "App/userFavoriteShops"
let FAVBAR = BASE_URL + "App/favorite_bar"
let GETALLBARDETAIL = BASE_URL + "App/clubdetails"




let ORDERPLACED = BASE_URL + "orders"
let FORGOTPASSWORD_API = BASE_URL + "user/forgot-password"
let RESTAURENTDETAIL = BASE_URL + "resturants/"






let SOCIALLOGINORREGISTER = BASE_URL + "socialRegister"

let NURSELIST = BASE_URL + "nurse/all"
let NURSEPROFILE = BASE_URL + "profile/nurses"
let HospitalPROFILE = BASE_URL + "profile/hospitals"
let HOSPITALREQUEST = BASE_URL + "hospital/request"
let NURSEAVAILABILITY = BASE_URL + "nurse/available"
let NURSESHIFTStart = BASE_URL + "nurse/shift/started"
let NURSELUNCHBREAK = BASE_URL + "nurse/shift/lunchBreak"
let NURSELUNCHBREAKENDED = BASE_URL + "nurse/shift/lunchBreakEnded"


let NURSEDECLINE = BASE_URL + "nurse/request/decline"
let NURSEACCEPT = BASE_URL + "nurse/request/accept"
let NURSESHIFT_END = BASE_URL + "nurse/shift/ended"
let NURSEPROFILEBYID = BASE_URL + "profile/nurses"
let PROFILERATING = BASE_URL + "profile/ratings"
let DIRECTREQUESTTONURSE = BASE_URL + "nurse/directRequest"
let NURSEREQUESTFORHOSPITAL = BASE_URL + "hospital/request"





let UPDATE_PROFILE_PIC = BASE_URL + "uploadPicture"
let UPDATE_PROFILE_INFO = BASE_URL + "user/update-profile"


let PROFILENOTARY = BASE_URL + "notary/profile"
let GETNOTARIFYPROFILE = BASE_URL + "notary/profile"
let PROFILENOTARYUpdate = BASE_URL + "notary/profile/2"
let GETSERVICE_LIST = BASE_URL + "notary/services"
let GETCLientREQUEST = BASE_URL + "client/request"
let GETNotaryRequestDocument = BASE_URL + "notary/request-documents"
let NOTARYSENDOFFER = BASE_URL + "notary/offers"
let GETCLIENTRequestDocument = BASE_URL + "client/request-documents"






let GETALLREVIEWLIST = BASE_URL + "notary/reviews"
let GETALLCertificate = BASE_URL + "notary/certificates"

let UPDATE_CERTIFICATE = BASE_URL + "notary/certificates"

let NOTARYPROFILEOFCLIENT = BASE_URL + "client/notary/profile"


let GETNOTARY_LIST = BASE_URL + "client/search"

let CLIENT_REQUEST = BASE_URL + "client/request"
let CLIENT_REQUESTFORNotaryInfo = BASE_URL + "client/request/"





let VERIFICATION_CODE = BASE_URL + "phoneVerification"
let BookAPPOINTMENT = BASE_URL + "bookAppointment"
//let SIGNUP = BASE_URL + "register"
let BROWSE_POST = BASE_URL + "browse"
let AUDITION_API = BASE_URL + "App/audition"
let GETALLCategories = BASE_URL + "categories"
let GETSUBCategorie = BASE_URL + "sub_categories"
let GETALLSHOP = BASE_URL + "getallshopsbysubcategoryid"
let FAVOURITE_SALOON = BASE_URL + "favorite_saloon"
let GETSHOP_DETAIL = BASE_URL + "shop_details"
let GETUSER_PROFILE = BASE_URL + "profile"
let GETSHOP_PRODUCT = BASE_URL + "getShopProductsbyShopId"
let GETSTAF_SHOP = BASE_URL + "getStaffbyShopId"
let GETFAV_SHOP = BASE_URL + "userFavoriteShops"




let GETSHOP_APPOINTMENT = BASE_URL + "getIosAppointmentsByShopId"
//let GETUSER_APPOINTMENT = BASE_URL + "userAppointments"



let GET_APPOINTMENT = BASE_URL + "userAppointments"





let GETContestantDetail = BASE_URL + "App/getDetail"
let GETContestTantVideos = BASE_URL + "App/getvideos"
let FORGOT_Password = BASE_URL + "user/forgot-password"
let CODE_SEND = BASE_URL + "verifycode"
//let RESET_PASSWORD = BASE_URL + "user/change-password"
let CHANGE_PASSPRofile = BASE_URL + "user/change-known-password"


let kAnimationDuration: Double = 0.25

let GETContestTantPhotos = BASE_URL + "App/getphotos"
let GETMediaPhotosAndVideo = BASE_URL + "App/getmedia"
let GETVote = BASE_URL + "App/vote"
let PULLTHEVOTE = BASE_URL + "App/voteher"

let GETSOcial = BASE_URL + "App/getsocial"
let SOCIAL_LOGIN = BASE_URL + "sociallogin"
let ADIM_NEWS   = BASE_URL + "App/news"
let ADIM_TEAM   = BASE_URL + "App/team"
let ADIM_TV   = BASE_URL + "App/adimtv"




let VIDEO_SEEN = BASE_URL + "post_seen"
let NEW_POST = BASE_URL + "new_post"
let RESPOND_POST = BASE_URL + "respondPost"
let PROFILE = BASE_URL + "getProfile"
let MY_POSTS_RESPONSE = BASE_URL + "myPosts"
let UPDATE_PROFILE = BASE_URL + "updateProfile"
let UPDATE_PASSWORD = BASE_URL + "updatePassword"
let SAVE_PURCHASE = BASE_URL + "savePurchase"
let POST_HANDSHAKE = BASE_URL + "postHandShake"
let GET_CAT = BASE_URL + "getCategories"
let GET_USER_BUSINESS = BASE_URL + "getUserBusiness"
let ADD_NEW_BUSINESS = BASE_URL + "addNewBusiness"
let EDIT_USER_BUSINESS = BASE_URL + "editUserBusiness"
let ADD_SCHEDULE = BASE_URL + "addNewSchedule"
let GET_PROFILE = BASE_URL + "getProfile"
let EDIT_SCHEDULE = BASE_URL + "editSchedule"
let POST_COMMENT = BASE_URL + "postComment"
let GET_COMMENTS = BASE_URL + "getBusinessComments"
let DELETE_SCHEDULE = BASE_URL + "deleteSchedule"
let ENABLE_SCHEDULE = BASE_URL + "enableSchedule"
let UPLOAD_GALLERY = BASE_URL + "uploadGallery"
let DELETE_GALLERY = BASE_URL + "deleteGallery"
let RESETCODE = BASE_URL + "checkResetCode"
let Logout = BASE_URL  + "logout"
let ChnagePassword  = BASE_URL + "changePassword"
let SESSIONEVALUATION  = BASE_URL + "session_evaluation"
let PROGRAMPOLL  = BASE_URL + "program_polls"
let INSERTUSERDEVICE  = BASE_URL + "insert_user_device"
let EVENTEVALUATION  = BASE_URL + "event_evaluation"




//var localUserData: UserData!
//var notificationType = "none"

var localUserData: UserInformation!


let kUserNameRequiredLength: Int = 4
let kValidationMessageMissingInput: String = "Please fill all the fields"
let kEmptyString: String = ""
let kPasswordRequiredLength: Int = 5
let kUserNameRequiredLengthForPhone: Int = 9
let kValidationMessageMissingInputPhone : String = "Please give the proper phone Number"

let KValidationPassword : String = "Password must be greater 6 digits"
let kValidationEmailInvalidInput: String = "Please enter valid Email Address"
let kUpdateTokenMessage: String = "user does not exists"
let KMessageTitle: String = "MobinP"

