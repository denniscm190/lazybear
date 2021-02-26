//
//  UserSettings+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//
//

import Foundation
import CoreData


extension UserSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettings> {
        return NSFetchRequest<UserSettings>(entityName: "UserSettings")
    }

    @NSManaged public var appIcon: String?
    @NSManaged public var changedAt: Date
    @NSManaged public var theme: String?
    @NSManaged public var newsLanguage: String?

}

extension UserSettings : Identifiable {

}
