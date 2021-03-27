//
//  LazyBearApp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

@main
struct LazyBearApp: App {
    let persistenceController = PersistenceController.shared  // Core Data init
    @ObservedObject var hapticsManager = HapticsManager()

    var body: some Scene {
        WindowGroup {
            if isAppAlreadyLaunchedOnce() {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(hapticsManager)
                
            } else {
                WelcomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(hapticsManager)
            }
        }
    }
    
    private func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "IsAppAlreadyLaunchedOnce") {
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            
            return true
        } else {
            return false
        }
    }
}
