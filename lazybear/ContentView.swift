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
    let persistenceController = PersistenceController.shared
    
    let cloud = CloudKitManager()
    @State var cloudFetch = [CKRecord]() { didSet { cloudValues() }}  // On change, call function
    @EnvironmentObject var apiAccess: ApiAccess

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
        .onAppear { cloud.query(recordType: "API") { self.cloudFetch = $0 } }  // Request CloudKit
    }
    
    // Assign values to the model
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
