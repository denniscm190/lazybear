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
    
    // Line chart tutorial
    func randomSample() -> [Double] {
        var randomArray = [Double]()
        for _ in 0..<100 {
            randomArray.append(Double.random(in: 1...100))
        }
        
        return randomArray
    }
}
