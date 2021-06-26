//
//  LazyBearApp.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 19/6/21.
//

import SwiftUI
import CoreData

@main
struct LazyBearApp: App {
    let persistenceController = PersistenceController.shared  // Core Data init
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
