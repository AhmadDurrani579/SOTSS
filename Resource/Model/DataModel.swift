//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class UserResponse: Mappable , NSCoding {

    var success                              :       Int?
    var message                              :       String?
    var result                               :       UserResult?
    var aboutResult                          :       AboutInfo?


    required init?(map: Map){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
     
        success  =  aDecoder.decodeObject(forKey: "success") as? Int
        message  =  aDecoder.decodeObject(forKey: "message") as? String
        result  =   aDecoder.decodeObject(forKey: "result")  as? UserResult
        
    }
    
    func encode(with aCoder: NSCoder) {
        success  =  aCoder.decodeObject(forKey: "success") as? Int
        message  =  aCoder.decodeObject(forKey: "message") as? String
        result  =   aCoder.decodeObject(forKey: "result")  as? UserResult

    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result    <- map["result"]
        aboutResult <- map["result"]
    }
}

class UserResult : Mappable , NSCoding {
    
    var userInfo: UserInformation?
    var event   : [EventObject]?
    var programSelect : [ProgramsObject]?
    var programTime     : [ProgramsTimeObject]?
    var participent     : [ParticipationUser]?
    var participentRole     : [ParticipationRole]?
    var faqEvent            : [EventFaqObject]?
    var happeningList            : [HappeningListObject]?
    var userMessage              : UserMessageObject?
    var associationObj           : [AssociationObject]?
    var ageGroup           : [AgeGroupObject]?
    var sourceGroup           : [SourceObject]?

    required init?(map: Map){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        userInfo  =   aDecoder.decodeObject(forKey: "user")  as? UserInformation
        event  =   aDecoder.decodeObject(forKey: "events")  as? [EventObject]
        programSelect  =   aDecoder.decodeObject(forKey: "programs")  as? [ProgramsObject]
        programTime  =   aDecoder.decodeObject(forKey: "programs")  as? [ProgramsTimeObject]
        participent  =   aDecoder.decodeObject(forKey: "participants")  as? [ParticipationUser]
        participentRole  =   aDecoder.decodeObject(forKey: "participant_roles")  as? [ParticipationRole]

    }
    
    func encode(with aCoder: NSCoder) {
        
        userInfo  =   aCoder.decodeObject(forKey: "user")  as? UserInformation
        event  =   aCoder.decodeObject(forKey: "events")  as? [EventObject]
        programSelect  =   aCoder.decodeObject(forKey: "programs")  as? [ProgramsObject]
        programTime  =   aCoder.decodeObject(forKey: "programs")  as? [ProgramsTimeObject]
        participent  =   aCoder.decodeObject(forKey: "participants")  as? [ParticipationUser]
        participentRole  =   aCoder.decodeObject(forKey: "participant_roles")  as? [ParticipationRole]
        
    }
    
    func mapping(map: Map) {
        userInfo <- map["user"]
        event    <- map["events"]
        programSelect <- map["programs"]
        programTime <- map["programs"]
        participent <- map["participants"]
        participentRole <- map["participant_roles"]
        faqEvent        <- map["event_faqs"]
        happeningList  <- map["happenings"]
        userMessage    <- map["user_messages"]
        associationObj <- map["associations"]
        ageGroup       <- map["age_groups"]
        sourceGroup       <- map["sources"]


    }
}

class AboutInfo  : Mappable {
    
    var name: String?
    var desig: String?
    var desc_1: String?
    var desc_2: String?
    var desc_3: String?
    var desc_4: String?
    var picture : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        desig <- map["desig"]
        desc_1 <- map["desc_1"]
        desc_2 <- map["desc_2"]
        desc_3 <- map["desc_3"]
        desc_4 <- map["desc_4"]
        picture <- map["picture"]
        
        
    }
}

class UserInformation : Mappable , NSCoding {
    
    var user_id: String?
    var participant_id: String?
    var first_name: String?
    var email: String?
    var last_name: String?
    var date_of_birth : String?
    var phone : String?
    var image : String?
    var qrcode     : String?
    var gender     : String?
    var city_id : String?
    var location_id : String?
    var other_location : String?
    var is_associate : String?
    var association_id : String?
    var profile_update_status : String?

    required init?(map: Map){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        user_id  =   aDecoder.decodeObject(forKey: "user_id")  as? String
        participant_id  =   aDecoder.decodeObject(forKey: "participant_id")  as? String
        first_name  =   aDecoder.decodeObject(forKey: "first_name")  as? String
        email  =   aDecoder.decodeObject(forKey: "email")  as? String
        last_name  =   aDecoder.decodeObject(forKey: "last_name")  as? String
        date_of_birth  =   aDecoder.decodeObject(forKey: "date_of_birth")  as? String
        phone  =   aDecoder.decodeObject(forKey: "phone")  as? String
        image  =   aDecoder.decodeObject(forKey: "image")  as? String
        qrcode  =   aDecoder.decodeObject(forKey: "qrcode")  as? String
        gender  =   aDecoder.decodeObject(forKey: "gender")  as? String
        city_id  =   aDecoder.decodeObject(forKey: "city_id")  as? String
        location_id  =   aDecoder.decodeObject(forKey: "location_id")  as? String
        other_location  =   aDecoder.decodeObject(forKey: "other_location")  as? String
        is_associate  =   aDecoder.decodeObject(forKey: "is_associate")  as? String
        association_id  =   aDecoder.decodeObject(forKey: "association_id")  as? String
        profile_update_status  =   aDecoder.decodeObject(forKey: "profile_update_status")  as? String


    }
    
    func encode(with aCoder: NSCoder) {
        
        user_id  =   aCoder.decodeObject(forKey: "user_id")  as? String
        participant_id  =   aCoder.decodeObject(forKey: "participant_id")  as? String
        first_name  =   aCoder.decodeObject(forKey: "first_name")  as? String
        email  =   aCoder.decodeObject(forKey: "email")  as? String
        last_name  =   aCoder.decodeObject(forKey: "last_name")  as? String
        date_of_birth  =   aCoder.decodeObject(forKey: "date_of_birth")  as? String
        phone  =   aCoder.decodeObject(forKey: "phone")  as? String
        image  =   aCoder.decodeObject(forKey: "image")  as? String
        qrcode  =   aCoder.decodeObject(forKey: "qrcode")  as? String
        gender  =   aCoder.decodeObject(forKey: "gender")  as? String
        city_id  =   aCoder.decodeObject(forKey: "city_id")  as? String
        location_id  =   aCoder.decodeObject(forKey: "location_id")  as? String
        other_location  =   aCoder.decodeObject(forKey: "other_location")  as? String
        is_associate  =   aCoder.decodeObject(forKey: "is_associate")  as? String
        association_id  =   aCoder.decodeObject(forKey: "association_id")  as? String
        profile_update_status  =   aCoder.decodeObject(forKey: "profile_update_status")  as? String

    }
    
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        participant_id <- map["participant_id"]
        first_name <- map["first_name"]
        email <- map["email"]
        last_name <- map["last_name"]
        date_of_birth <- map["date_of_birth"]
        phone <- map["phone"]
        image <- map["image"]
        qrcode <- map["qrcode"]
        gender <- map["gender"]
        city_id <- map["city_id"]
        location_id <- map["location_id"]
        other_location <- map["other_location"]
        is_associate <- map["is_associate"]
        association_id <- map["association_id"]
        profile_update_status <- map["profile_update_status"]

        
    }
}


class EventObject : Mappable {
    
    var event_id: String?
//    var eventids: Int?

    var event_title: String?
    var event_desc: String?
    var event_category : String?
    var active: String?
    var start_date: String?
    var end_date: String?
    var display_date: String?
    var evaluation_exists: String?
    var evaluation_active: String?
    var evaluation_submitted: String?
    var session_tagline: String?
    var speaker_tagline: String?
    var fullsteam_desc: String?
    var location      : [LocationObject]?
    var eventDate     : [EventDateObject]?
    var activityType  : [EventActivityType]?
    var eventDimention : [EventDimensions]?
    var eventVenue     : [EventVenue]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        event_title <- map["event_title"]
        event_desc <- map["event_desc"]
        event_category <- map["event_category"]
        active <- map["active"]
        start_date <- map["start_date"]
        end_date <- map["end_date"]
        display_date <- map["display_date"]
        evaluation_exists <- map["evaluation_exists"]
        evaluation_active <- map["evaluation_active"]
        evaluation_submitted <- map["evaluation_submitted"]
        session_tagline <- map["session_tagline"]
        speaker_tagline <- map["speaker_tagline"]
        fullsteam_desc <- map["fullsteam_desc"]
        location <- map["locations"]
        eventDate <- map["event_dates"]
        activityType <- map["activity_types"]
        eventDimention <- map["dimensions"]
        eventVenue <- map["venues"]
        
    }
}

class LocationObject : Mappable {
    
    var location_id: String?
    var location_name: String?
    var city_id: String?
    var city_name: String?
    var status: String?
    var lat: String?
    var long: String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        location_id <- map["location_id"]
        location_name <- map["location_name"]
        city_id <- map["city_id"]
        city_name <- map["city_name"]
        status <- map["status"]
        lat <- map["lat"]
        long <- map["long"]

        
    }
}



class EventDateObject : Mappable {
    
    var event_display_date: String?
    var event_date: String?
    var event_day: Int?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_display_date <- map["event_display_date"]
        event_date <- map["event_date"]
        event_day <- map["event_day"]
        
    }
}

class EventActivityType : Mappable {
    
    var activity_desc: String?
    var activity_type_id: String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        activity_desc <- map["activity_desc"]
        activity_type_id <- map["activity_type_id"]
        
    }
}

class EventDimensions : Mappable {
    
    var short_name: String?
    var theme_desc: String?
    var theme_id: String?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        short_name <- map["short_name"]
        theme_desc <- map["theme_desc"]
        theme_id <- map["theme_id"]

        
    }
}

class EventVenue : Mappable {
    
    var location_id: String?
    var sort_order: String?
    var venue_id: String?
    var venue_title: String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        location_id <- map["location_id"]
        sort_order <- map["sort_order"]
        venue_id <- map["venue_id"]
        venue_title <- map["venue_title"]

        
        
    }
}


class ProgramsObject : Mappable {
    
    var event_id: String?
    var schedule_id: String?
    var user_id    : String?
    var poll_exists: String?
    var poll_active: String?
    var poll_submitted: String?
    var evaluation_exists: String?
    var evaluation_active: String?
    var evaluation_submitted   : String?
    var attendance   : String?
    var activity_type_id   : String?
    var activity_desc   : String?
    var activity_id   : String?
    var activity_title   : String?
    var activity_date   : String?
    var abstract   : String?
    var start_time   : String?
    var end_time   : String?
    var display_date   : String?
    var inactive_status : String?
    var day_session : String?

    var location_id   : String?
    var theme_id   : String?
    var theme_desc : String?
    var venue_id   : String?
    var venue_title   : String?
    var allow_register : String?
    var participant   : [ParticipationObject]?


    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        schedule_id <- map["schedule_id"]
        user_id     <- map["user_id"]
        poll_exists <- map["poll_exists"]
        poll_active <- map["poll_active"]
        poll_submitted <- map["poll_submitted"]
        evaluation_exists <- map["evaluation_exists"]
        evaluation_active <- map["evaluation_active"]
        attendance <- map["attendance"]
        activity_type_id <- map["activity_type_id"]
        activity_desc <- map["activity_desc"]
        activity_id <- map["activity_id"]
        activity_title <- map["activity_title"]
        activity_date <- map["activity_date"]
        abstract <- map["abstract"]
        day_session <- map["day_session"]

        
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        display_date <- map["display_date"]
        inactive_status <- map["inactive_status"]
        location_id <- map["location_id"]
        theme_id <- map["theme_id"]
        venue_id <- map["venue_id"]
        venue_title <- map["venue_title"]
        participant <- map["participants"]
        theme_desc  <- map["theme_desc"]
        allow_register <- map["allow_register"]

        
    }
}

class ProgramsTimeObject : Mappable {
    
    var event_id: String?
    var schedule_id: String?
    var activity_type_id   : String?
    var activity_desc   : String?
    var activity_id   : String?
    var activity_title   : String?
    var activity_date   : String?
    var abstract   : String?
    var start_time   : String?
    var end_time   : String?
    var display_date   : String?
    var location_id   : String?
    var theme_id   : String?
    var venue_id   : String?
    var venue_title   : String?
    var participant   : [ParticipationObject]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        schedule_id <- map["schedule_id"]
        activity_type_id <- map["activity_type_id"]
        activity_desc <- map["activity_desc"]
        activity_id <- map["activity_id"]
        activity_title <- map["activity_title"]
        activity_date <- map["activity_date"]
        abstract <- map["abstract"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        display_date <- map["display_date"]
        location_id <- map["location_id"]
        theme_id <- map["theme_id"]
        venue_id <- map["venue_id"]
        venue_title <- map["venue_title"]
        participant <- map["participants"]
        
    }
}

class ParticipationObject : Mappable {
    
    var participant_id: String?
    var participant_name: String?
    var participant_photo: String?
    var designation: String?
    var experties: String?
    var profile_desc: String?
    var gender: String?
    var linkedin_url: String?
    var twitter_url: String?
    var role_id: String?
    var role_desc: String?
    var sub_designation : String?
    var profile_tags : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        participant_id <- map["participant_id"]
        participant_name <- map["participant_name"]
        participant_photo <- map["participant_photo"]
        role_id <- map["role_id"]
        designation <- map["designation"]
        experties <- map["experties"]
        profile_desc <- map["profile_desc"]
        gender <- map["gender"]
        linkedin_url <- map["linkedin_url"]
        twitter_url <- map["twitter_url"]
        profile_tags <- map["profile_tags"]
        sub_designation <- map["sub_designation"]

        
        
        
    }
}

class ParticipationUser : Mappable {
    
    var event_id: String?
    var participant_id: String?
    var user_id: String?
    var title: String?
    var first_name: String?
    var middle_name: String?
    var last_name: String?
    var participant_name: String?
    var gender: String?
    var role_id: String?
    var role_desc: String?
    var participant_photo: String?
    var featured: String?
    var designation: String?
    var sub_designation: String?
    var experties: String?
    var profile_desc: String?
    var profile_tags: String?
    var twitter_url: String?
     var linkedin_url: String?
   
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        participant_id <- map["participant_id"]
        user_id <- map["user_id"]
        title <- map["title"]
        first_name <- map["first_name"]
        middle_name <- map["middle_name"]
        last_name <- map["last_name"]
        participant_name <- map["participant_name"]
        gender <- map["gender"]
        role_id <- map["role_id"]
        role_desc <- map["role_desc"]
        participant_photo <- map["participant_photo"]
        featured <- map["featured"]
        designation <- map["designation"]
        sub_designation <- map["sub_designation"]
        experties <- map["experties"]
        profile_desc <- map["profile_desc"]
        twitter_url <- map["twitter_url"]
        linkedin_url <- map["linkedin_url"]

        
        
        
    }
}


class ParticipationRole : Mappable {
    
    var role_id: String?
    var role_desc: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        role_id <- map["role_id"]
        role_desc <- map["role_desc"]
        
    }
}

class EventFaqObject : Mappable {
    
    var question_id: String?
    var question_title: String?
    var question_detail: String?
    var status: String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        question_id <- map["question_id"]
        question_title <- map["question_title"]
        question_detail <- map["question_detail"]
        status <- map["status"]

        
    }
}

class HappeningListObject : Mappable {
    
    var id: String?
    var title: String?
    var categories: String?
    var description: String?
    var url: String?
    var image_url : String?
    var date_filter: String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        categories <- map["categories"]
        description <- map["description"]
        url <- map["url"]
        image_url <- map["image_url"]
        date_filter <- map["date_filter"]

        
    }
}

class UserMessageObject : Mappable {
    
    var messages: [MessageObject]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        messages <- map["messages"]

        
    }
}

class MessageObject : Mappable  {
    
    var msg_id: String?
    var from_user_id: String?
    var to_user_id: String?
    var msg_desc: String?
    var sent_date: String?
    var read_status: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        msg_id <- map["msg_id"]
        from_user_id <- map["from_user_id"]
        to_user_id <- map["to_user_id"]
        msg_desc <- map["msg_desc"]
        sent_date <- map["sent_date"]
        read_status <- map["read_status"]
        
        
    }
}

class Session   :   Mappable {
    
    var success                              :       Int?
    var message                              :       String?
    var result                               :       SessionEvaluation?
    
    
    required init?(map: Map){
        
    }
    
   
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result    <- map["result"]
    }
}

class SessionEvaluation : Mappable  {
    
    var sessionEvaluation         : SessionEvaluationObject?
    var pollEvaluation            : SessionEvaluationObject?
    var eventEvaluation           : SessionEvaluationObject?

 
    required init?(map: Map){
        
    }
    
   
    
    func mapping(map: Map) {
        eventEvaluation <- map["event_evaluation"]

        sessionEvaluation <- map["session_evaluation"]
        pollEvaluation <- map["program_polls"]

    }
}


class SessionEvaluationObject : Mappable {
    
    var message: String?
    var evaluationObject      : SessionEvaluationQuestionObject?
    var sessionQuestionObject : SessionEvaluationQuestionObject?
    var pollQuestionObject    : PollQuestionObject?
    var status: String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        message <- map["message"]
        sessionQuestionObject <- map["0"]
        pollQuestionObject    <- map["0"]
        evaluationObject       <- map["0"]

    }
}

class SessionEvaluationQuestionObject : Mappable {
    
    var event_id: String?
    var message: String?
    
    var schedule_id: String?
    var evaluation_id: String?
    var evaluation_title: String?
    var status: String?
    var sessionQuestion : [SessionQuestion]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        event_id <- map["event_id"]
        schedule_id <- map["schedule_id"]
        evaluation_id <- map["evaluation_id"]
        evaluation_title <- map["evaluation_title"]
        status <- map["status"]
        message <- map["message"]
        
        sessionQuestion <- map["questions"]
    }
}


class SessionQuestion : Mappable {
    
    var question_id: String?
    var question_desc: String?
    var question_type: String?
    var opt_img_type: String?
    var opt_layout: String?
    var option : [SessionQuestionOption]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        question_id <- map["question_id"]
        question_desc <- map["question_desc"]
        question_type <- map["question_type"]
        opt_img_type <- map["opt_img_type"]
        opt_layout <- map["opt_layout"]
        option      <- map["options"]
    }
}

class SessionQuestionOption : Mappable {
    
    var option_id: String?
    var option_desc: String?
    var icon_url: String?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        option_id <- map["option_id"]
        option_desc <- map["option_desc"]
        icon_url <- map["icon_url"]
    }
}


class PollQuestionObject : Mappable {
    
    var schedule_id: String?
    var poll_id: String?
    
    var poll_name: String?
    var poll_status: String?
    var poll_code: String?
    var status: String?
    var sessionQuestion : [SessionQuestion]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        schedule_id <- map["schedule_id"]
        poll_id <- map["poll_id"]
        poll_name <- map["poll_name"]
        poll_status <- map["poll_status"]
        poll_code <- map["poll_code"]
        sessionQuestion <- map["questions"]
    }
}


class AssociationObject : Mappable {
    
    var association_id: String?
    var association_name: String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        association_id <- map["association_id"]
        association_name <- map["association_name"]
    }
}

class SourceObject : Mappable {
    
    var source_id: String?
    var source_name: String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        source_id <- map["source_id"]
        source_name <- map["source_name"]
    }
}

class AgeGroupObject : Mappable {
    
    var age_group_id: String?
    var age_group: String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        age_group_id <- map["age_group_id"]
        age_group <- map["age_group"]
    }
}




