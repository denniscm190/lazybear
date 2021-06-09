//
//  RowShape.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/6/21.
//

import SwiftUI

struct RowShape: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color("CustomSecondaryBackground"))
            .if(colorScheme == .light) { content in
                // Apply shadow only when is not dark mode
                content
                    .shadow(color: Color(.gray).opacity(0.15), radius: 10)
            }
    }
}

struct RowShape_Previews: PreviewProvider {
    static var previews: some View {
        RowShape()
    }
}
