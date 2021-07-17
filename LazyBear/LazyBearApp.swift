//
//  lazybearApp.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

@main
struct lazybearApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
