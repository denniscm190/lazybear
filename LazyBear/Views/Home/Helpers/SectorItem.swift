//
//  SectorItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct SectorItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image("Technology")
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white, lineWidth: 4))
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .frame(width: 170, height: 170)
    }
}

struct SectorItem_Previews: PreviewProvider {
    static var previews: some View {
        SectorItem()
    }
}
