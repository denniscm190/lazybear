//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

struct ContentView: View {
    // Start ObservedObjects
    @ObservedObject var hudManager = HUDManager()
    
    // Fetch user appearence settings
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                // First view
                Watchlist(hudManager: hudManager)
                    .tabItem {
                        Label("Watchlist", systemImage: "list.dash")
                    }
                
                // First view
                Search(hudManager: hudManager)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                // First view
                Settings()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            
            HUD(text: hudManager.text, image: hudManager.image)
                .offset(y: hudManager.isShowing ? 0 : -100)
                .animation(.easeInOut)
        }
        .accentColor(Color("\(userSettings.first?.theme?.lowercased() ?? "default")Accent"))
        // If this value is not optional it will cause a crash
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
