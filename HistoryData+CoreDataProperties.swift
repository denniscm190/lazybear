//
//  HistoryData+CoreDataProperties.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/2/21.
//
//

import Foundation
import CoreData


extension HistoryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryData> {
        return NSFetchRequest<HistoryData>(entityName: "HistoryData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?

}

extension HistoryData : Identifiable {

}
