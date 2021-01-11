//
//  LazyBearApp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI
import StoreKit

@main
struct LazyBearApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Env1()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
