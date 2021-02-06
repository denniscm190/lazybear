//
//  Test.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct Test: View {
    @State private var users = ["Paul", "Taylor", "Adele"]

    var body: some View {
        TabView {
        // First view
            NavigationView {
                Text("Hello")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        
        // Second view
            Text("Hello")
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Watchlist")
            }
        
        // Third view
            Text("Hello")
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }

    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
}
