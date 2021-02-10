//
//  AppView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI
import CloudKit

/*
 This view is called inmediately after the app is launched. When it appears, it will
 request from my Apple server the API keys and URL to request the IEX Cloud API in later views.
 If the request is successful, then we can show the ContentView()
*/

struct AppView: View {
    let persistenceController = PersistenceController.shared  // Core Data
    let cloud = CloudKitManager() // CloudKit request function
    @EnvironmentObject var apiManager: ApiManager  // Api info
    @State var cloudFetch = [CKRecord]() { didSet { cloudValues() }} // Fetch arrives here
    
    var body: some View {
        VStack {
            if apiManager.showingView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(apiManager)
            }
        }
        // Request CloudKit
        .onAppear { cloud.query(recordType: "API") { cloudFetch = $0 } }
    }
    
    // Assign CloudKit fetch to model structure
    private func cloudValues() {
        var results = [ApiManagerModel]()
        cloudFetch.forEach({ (result) in
            
            // In result, search for the key named 'key', 'name', and 'url'
            let key = result.object(forKey: "key") as? String
            let name = result.object(forKey: "name") as? String
            let url = result.object(forKey: "url") as? String
            
            let value = ApiManagerModel(key: key, name: name, url: url)
            results.append(value)
        })
        
        // Main thread
        DispatchQueue.main.async {
            apiManager.results = results
            
            // Everything is ok, so I can show the ContentView()
            apiManager.showingView = true
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
