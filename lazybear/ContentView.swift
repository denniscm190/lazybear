//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI
import CoreData
import CloudKit

struct ContentView: View {
    @State var searchedCompany = String()
    @State public var showingSearch: Bool = false
    @State var cloudFetch = [CKRecord]() { didSet { cloudValues() }}   // CloudKit fetch arrives here
    
    let persistenceController = PersistenceController.shared  // Core data
    let cloud = CloudKitManager()  // CloudKit fetch function
    
    @EnvironmentObject var apiAccess: ApiAccess  // Env apis info

    var body: some View {
        VStack(alignment: .leading) {
            if apiAccess.showingView {
                SuperTitle(name: "Home")
                SearchBar(searchedText: $searchedCompany, showingSearch: $showingSearch)

                if showingSearch {
                    if searchedCompany.count > 2 {
                        CompanyList(searchedCompany: $searchedCompany)
                    }
                    Spacer()
                } else {
                    Watchlist()
                }
            }
        }
        .onAppear { cloud.query(recordType: "API") { cloudFetch = $0 } }  // Request CloudKit 
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApiAccess())
    }
}
