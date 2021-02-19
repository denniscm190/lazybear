//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // First view
            Watchlist()
                .tabItem {
                    Label("Watchlist", systemImage: "list.dash")
                }
            
            // First view
            Search()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            // First view
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
