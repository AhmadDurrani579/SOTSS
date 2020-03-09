//
//  EventModel+CoreDataProperties.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 21/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//
//

import Foundation
import CoreData


extension EventModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventModel> {
        return NSFetchRequest<EventModel>(entityName: "EventModel")
    }

    @NSManaged public var event_id: String?
    @NSManaged public var event_title: String?
    @NSManaged public var event_desc: String?
    @NSManaged public var event_category: String?
    @NSManaged public var active: String?
    @NSManaged public var start_date: String?
    @NSManaged public var end_date: String?
    @NSManaged public var display_date: String?
    @NSManaged public var location_id: String?
    @NSManaged public var location_name: String?
    @NSManaged public var city_name: String?
    @NSManaged public var session_tagline: String?
    @NSManaged public var speaker_tagline: String?
    @NSManaged public var fullsteam_desc: String?

}
