//
//  WatchlistCompany+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//
//

import Foundation
import CoreData


extension WatchlistCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchlistCompany> {
        return NSFetchRequest<WatchlistCompany>(entityName: "WatchlistCompany")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var exchange: String?
    @NSManaged public var exchangeSuffix: String?
    @NSManaged public var exchangeName: String?
    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var type: String?
    @NSManaged public var iexId: String?
    @NSManaged public var region: String?
    @NSManaged public var currency: String?
    @NSManaged public var isEnabled: Bool
    @NSManaged public var figi: String?
    @NSManaged public var cik: String?
    @NSManaged public var lei: String?

}

extension WatchlistCompany : Identifiable {

}
