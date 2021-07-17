//
//  ContentView.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var tab: Tab = .watchlist
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var companies: FetchedResults<Company>
    
    var body: some View {
        TabView(selection: $tab) {
            Watchlist()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Watchlist")
                }
                .tag(Tab.watchlist)
            
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(Tab.search)
        }
        .onAppear(perform: createDefaultWatchlist)
    }
    
    private enum Tab {
        case watchlist, search, settings
    }
    
    // MARK: - Create default watchlist
    private func createDefaultWatchlist() {
        if companies.isEmpty {
            let defaultCompanies = [
                "AAPL": "Apple Inc",
                "AMZN": "Amazon.com Inc.",
                "BRK.A": "Berkshire Hathaway Inc.",
                "GS": "Goldman Sachs Group, Inc.",
                "TSLA": "Tesla Inc",
                "MSFT": "Microsoft Corporation",
                "WMT": "Walmart Inc",
                "DIS": "Walt Disney Co (The)",
                "NKE": "Nike, Inc."
            ]
            
            for defaultCompany in defaultCompanies {
                withAnimation {
                    let company = Company(context: viewContext)
                    company.symbol = defaultCompany.key
                    company.companyName = defaultCompany.value

                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
