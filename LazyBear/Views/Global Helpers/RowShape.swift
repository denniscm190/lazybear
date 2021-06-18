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
            .foregroundColor(Color("customSecondaryBackground"))
            .if(colorScheme == .light) { content in
                // Apply shadow only when is not dark mode
                content
                    .shadow(color: Color(.gray).opacity(0.15), radius: 10)
            }
    }
}

/*
 Apply modifiers to the passed view on some condition
 */
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

struct RowShape_Previews: PreviewProvider {
    static var previews: some View {
        RowShape()
    }
}
