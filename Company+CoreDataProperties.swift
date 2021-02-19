//
//  Company+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var symbol: String
    @NSManaged public var exchange: String
    @NSManaged public var exchangeName: String
    @NSManaged public var name: String
    @NSManaged public var region: String
    @NSManaged public var currency: String
    @NSManaged public var cik: String

}

