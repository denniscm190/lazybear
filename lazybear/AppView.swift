//
//  AppView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI
import CloudKit

struct AppView: View {
    let persistenceController = PersistenceController.shared // Core Data
    
    // <--------- CloudKit --------->
    let cloud = CloudKitManager()
    @EnvironmentObject var apiAccess: ApiAccess  // Env apis info
    @State var cloudFetch = [CKRecord]() { didSet { cloudValues() }}  // Fetch arrives here
    // <--------- CloudKit --------->
    
    var body: some View {
        VStack {
            if apiAccess.showingView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(apiAccess)  // Api info (url and token)
            }
        }.onAppear { cloud.query(recordType: "API") { cloudFetch = $0 } }  // Request CloudKit
    }
    
    // Assign CloudKit fetch to model
    private func cloudValues() {
        var results = [ApiModel]()
        cloudFetch.forEach({ (result) in
            let key = result.object(forKey: "key") as? String
            let name = result.object(forKey: "name") as? String
            let url = result.object(forKey: "url") as? String
            
            let value = ApiModel(key: key, name: name, url: url)
            results.append(value)
        })
        // Main thread
        DispatchQueue.main.async {
            apiAccess.results = results
            apiAccess.showingView = true
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
