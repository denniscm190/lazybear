//
//  LazyBearApp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI

@main
struct LazyBearApp: App {
    let persistenceController = PersistenceController.shared
    var apiAccess = ApiAccess()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(apiAccess)  // Api info (url and token)
        }
    }
}
