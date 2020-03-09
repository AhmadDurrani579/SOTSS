//
//  ProgramModel+CoreDataProperties.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 22/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//
//

import Foundation
import CoreData


extension ProgramModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramModel> {
        return NSFetchRequest<ProgramModel>(entityName: "ProgramModel")
    }

    @NSManaged public var abstract: String?
    @NSManaged public var activity_date: String?
    @NSManaged public var activity_desc: String?
    @NSManaged public var activity_id: String?
    @NSManaged public var activity_title: String?
    @NSManaged public var activity_type_id: String?
    @NSManaged public var allow_register: String?
    @NSManaged public var attendance: String?
    @NSManaged public var day_session: String?
    @NSManaged public var display_date: String?
    @NSManaged public var end_time: String?
    @NSManaged public var evaluation_active: String?
    @NSManaged public var evaluation_exists: String?
    @NSManaged public var evaluation_submitted: String?
    @NSManaged public var event_id: String?
    @NSManaged public var inactive_status: String?
    @NSManaged public var location_id: String?
    @NSManaged public var poll_active: String?
    @NSManaged public var poll_exists: String?
    @NSManaged public var poll_submitted: String?
    @NSManaged public var schedule_id: String?
    @NSManaged public var start_time: String?
    @NSManaged public var theme_desc: String?
    @NSManaged public var theme_id: String?
    @NSManaged public var user_id: String?
    @NSManaged public var venue_id: String?
    @NSManaged public var venue_title: String?
    @NSManaged public var participantInProgram: NSSet?

}

// MARK: Generated accessors for participantInProgram
extension ProgramModel {

    @objc(addParticipantInProgramObject:)
    @NSManaged public func addToParticipantInProgram(_ value: Participation)

    @objc(removeParticipantInProgramObject:)
    @NSManaged public func removeFromParticipantInProgram(_ value: Participation)

    @objc(addParticipantInProgram:)
    @NSManaged public func addToParticipantInProgram(_ values: NSSet)

    @objc(removeParticipantInProgram:)
    @NSManaged public func removeFromParticipantInProgram(_ values: NSSet)

}
