//
//  CloudKitManager.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI
import CloudKit

class CloudKitManager {
    func query(recordType: String, recordName: String) -> CKRecord {  // recordType = "Database", e.g "API" / recordName = "Name", e.g iexProduction
        let publicDatabase = CKContainer.default().publicCloudDatabase
        
        // Query arguments
        let recordID = CKRecord.ID(recordName: recordName)
        let predicate = NSPredicate(format: "recordID = %@", recordID)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        // Query begins
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) in
            guard error != nil else {  // If error is nil, then print results
                print("Successfull CloudKit query")

            }
            
            print("CloudKit query went wrong")
            print(error!.localizedDescription)
        }
    }
}
