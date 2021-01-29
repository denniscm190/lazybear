//
//  LogoModifier.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI

struct LogoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 40, maxHeight: 40)
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}
