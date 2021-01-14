//
//  FavCompany+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/1/21.
//
//

import Foundation
import CoreData


extension FavCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavCompany> {
        return NSFetchRequest<FavCompany>(entityName: "FavCompany")
    }

    @NSManaged public var cik: Int32
    @NSManaged public var symbol: String
    @NSManaged public var name: String

}

extension FavCompany : Identifiable {

}
