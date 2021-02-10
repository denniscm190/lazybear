//
//  LazyBearApp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI

@main
struct LazyBearApp: App {
    let persistenceController = PersistenceController.shared // Core Data
    var apiManager = ApiManager() // For Cloudkit request

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)  // Pass Core Data
                .environmentObject(apiManager)  // Pass Api info
        }
    }
}
