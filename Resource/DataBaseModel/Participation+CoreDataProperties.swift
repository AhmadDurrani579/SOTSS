//
//  Participation+CoreDataProperties.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 22/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//
//

import Foundation
import CoreData


extension Participation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Participation> {
        return NSFetchRequest<Participation>(entityName: "Participation")
    }

    @NSManaged public var designation: String?
    @NSManaged public var experties: String?
    @NSManaged public var gender: String?
    @NSManaged public var linkedin_url: String?
    @NSManaged public var participant_id: String?
    @NSManaged public var participant_name: String?
    @NSManaged public var participant_photo: String?
    @NSManaged public var profile_desc: String?
    @NSManaged public var profile_tags: String?
    @NSManaged public var role_desc: String?
    @NSManaged public var role_id: String?
    @NSManaged public var sub_designation: String?
    @NSManaged public var twitter_url: String?
    @NSManaged public var particpant: ProgramModel?

}
