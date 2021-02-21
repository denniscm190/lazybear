//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var hudManager = HUDManager()
    
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
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
