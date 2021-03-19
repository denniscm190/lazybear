//
//  Haptics.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/3/21.
//

import SwiftUI
import CoreHaptics

class Haptics {
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
