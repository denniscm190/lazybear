//
//  UserSettings+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/3/21.
//
//

import Foundation
import CoreData


extension UserSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettings> {
        return NSFetchRequest<UserSettings>(entityName: "UserSettings")
    }

    @NSManaged public var username: String
    @NSManaged public var body: String
    @NSManaged public var bodyColor: String
    @NSManaged public var eyes: String
    @NSManaged public var facialHair: String
    @NSManaged public var hair: String
    @NSManaged public var hairColor: String
    @NSManaged public var mouth: String
    @NSManaged public var nose: String
    @NSManaged public var skinTone: String
    @NSManaged public var background: String

}

extension UserSettings : Identifiable {

}
