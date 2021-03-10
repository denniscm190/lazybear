//
//  HUDManager.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI

enum HudType {
    case notification, action
}

class HudManager: ObservableObject {
    @Published var showNotification = false
    @Published var showAction = false
    
    func selectHud(type: HudType) {
        if type == .notification {
            self.showNotification = true
            
            // Dimiss after time
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showNotification = false
            }
        } else if type == .action {
            self.showAction = true
        }
    }
}
