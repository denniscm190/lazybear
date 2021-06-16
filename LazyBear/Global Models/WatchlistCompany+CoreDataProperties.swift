//
//  WatchlistCompany+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/6/21.
//
//

import Foundation
import CoreData


extension WatchlistCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchlistCompany> {
        return NSFetchRequest<WatchlistCompany>(entityName: "WatchlistCompany")
    }

    @NSManaged public var name: String
    @NSManaged public var symbol: String
    @NSManaged public var watchlistName: String

}
