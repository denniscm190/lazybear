//
//  CustomRectangleBox.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct CustomRectangleBox: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color("customSecondaryBackground"))
            .if(colorScheme == .light) { content in
                content.shadow(color: Color(.systemGray).opacity(0.25), radius: 10, x: 0.0, y: 0.0)
            }
            
    }
}

struct CustomRectangleBox_Previews: PreviewProvider {
    static var previews: some View {
        CustomRectangleBox()
    }
}
