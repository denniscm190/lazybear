//
//  WatchlistCompany+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/3/21.
//
//

import Foundation
import CoreData


extension WatchlistCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchlistCompany> {
        return NSFetchRequest<WatchlistCompany>(entityName: "WatchlistCompany")
    }

    @NSManaged public var symbol: String
    @NSManaged public var name: String
    @NSManaged public var watchlist: String

}

extension WatchlistCompany : Identifiable {

}

extension WatchlistCompany {
    static func == (lhs: WatchlistCompany, rhs: WatchlistCompany) -> Bool {
        print("Custom equation has been called")
        return lhs.id == rhs.id
    }
}
