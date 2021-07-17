//
//  Company+CoreDataProperties.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var symbol: String
    @NSManaged public var companyName: String

}

extension Company : Identifiable {

}
