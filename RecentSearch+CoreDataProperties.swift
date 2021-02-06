//
//  RecentSearch+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//
//

import Foundation
import CoreData


extension RecentSearch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearch> {
        return NSFetchRequest<RecentSearch>(entityName: "RecentSearch")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var date: Date?

}

extension RecentSearch : Identifiable {

}
