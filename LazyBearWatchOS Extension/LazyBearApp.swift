//
//  LazyBearApp.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 19/6/21.
//

import SwiftUI

@main
struct LazyBearApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
