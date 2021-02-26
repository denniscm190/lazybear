//
//  HUDManager.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI

class HUDManager: ObservableObject {
    var text = "Company saved"
    var image = "checkmark.circle"
    @Published var isShowing = false
    
    func show(text: String, image: String) {
        self.text = text
        self.image = image
        self.isShowing = true
        
        // Dimiss after time
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isShowing = false
        }
    }
}
