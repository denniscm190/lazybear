//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var hudManager: HudManager
    
    // Fetch user appearence settings
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        ZStack(alignment: .top) {
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
            
            // Show HUDs
            // Notification
            Notification(text: "Company saved", image: "checkmark.circle")
                .offset(y: hudManager.showNotification ? 0 : -100)
                .animation(.easeInOut)
            
            // Action sheet
            ZStack(alignment: .bottom) {
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(hudManager.showAction ? 0.2: 0)
                    .animation(.easeInOut)
                    .onTapGesture { hudManager.showAction = false }
                
                ActionView()
                    .offset(y: hudManager.showAction ? 0 : 250)
                    .animation(.easeInOut)
                    .padding(.horizontal)
            }
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
