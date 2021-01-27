//
//  CloudKitManager.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI
import CloudKit

class CloudKitManager {
    func query(recordType: String, recordName: String, completition: @escaping ([CKRecord]) -> Void) {  // recordType = "Database", e.g "API"
        let publicDatabase = CKContainer.default().publicCloudDatabase
        
        // Query arguments
        let recordID = CKRecord.ID(recordName: recordName)  // e.g iexApiProduction
        let predicate = NSPredicate(format: "recordID = %@", recordID)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        // Query begins
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) in
            if error != nil {
                print("CloudKit query went wrong")
                print(error!.localizedDescription)
                
                completition([CKRecord]())  // Return empty if error

            } else {

                if let results = results {
                    print("Succesfull CloudKit query")
                    
                    completition(results)  // Return value for key ...
                }
            }
        }
    }
}
