//
//  Favourite+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/1/21.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var cik: Int16
    @NSManaged public var isFavourite: Bool

}

extension Favourite : Identifiable {

}
