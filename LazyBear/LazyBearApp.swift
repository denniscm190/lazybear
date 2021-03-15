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
    
    // Start ObservedObjects
    @ObservedObject var hudManager = HudManager()
    @ObservedObject var companyOption = CompanyOption()
    @ObservedObject var deviceSize = DeviceSize()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(hudManager)
                .environmentObject(companyOption)
                .environmentObject(deviceSize)
        }
    }
}
