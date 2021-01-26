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

    var body: some Scene {
        WindowGroup {
            Test()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
