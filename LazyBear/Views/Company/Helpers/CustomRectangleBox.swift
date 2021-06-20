//
//  CustomRectangleBox.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct CustomRectangleBox: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.white)
            .shadow(color: Color(.systemGray).opacity(0.25), radius: 10, x: 0.0, y: 0.0)
    }
}

struct CustomRectangleBox_Previews: PreviewProvider {
    static var previews: some View {
        CustomRectangleBox()
    }
}
