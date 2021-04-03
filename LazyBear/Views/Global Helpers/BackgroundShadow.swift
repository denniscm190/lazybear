//
//  BackgroundShadow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct BackgroundShadow: View {
    @EnvironmentObject var hudManager: HudManager
    
    var body: some View {
        Color(.black)
            .edgesIgnoringSafeArea(.all)
            .opacity(hudManager.showSearchHelper ? 0.2: 0)
            .animation(.easeInOut)
            .onTapGesture { hudManager.showSearchHelper = false }
    }
}

struct BackgroundShadow_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundShadow()
            .environmentObject(HudManager())
    }
}
