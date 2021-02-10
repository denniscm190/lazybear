//
//  TitleMod.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/2/21.
//

import SwiftUI

/*
 Views title modifier inside Company
 */

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding([.leading, .top])
    }
}
