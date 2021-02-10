//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apiManager: ApiManager  // Api info
    let persistenceController = PersistenceController.shared // Core Data

    var body: some View {
        TabView {
        // First view
            Search()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(apiManager)
                
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        
        // Second view
            Watchlist()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Watchlist")
            }
        
        // Third view
            Settings()
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
