//
//  LazyBearApp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI
import Purchases

@main
struct LazyBearApp: App {
    let persistenceController = PersistenceController.shared  // Core Data init
    init() {  /// Revenue Cat configuration
            Purchases.configure(withAPIKey: "ZnlVFgEqTmhLagtzgFawvlhAROXQjyFi")
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
