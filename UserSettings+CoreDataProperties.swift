//
//  UserSettings+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//
//

import Foundation
import CoreData


extension UserSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettings> {
        return NSFetchRequest<UserSettings>(entityName: "UserSettings")
    }

    @NSManaged public var username: String?
    @NSManaged public var avatar: String?

}

extension UserSettings : Identifiable {

}
