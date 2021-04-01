//
//  ContainerHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI

struct ContainerHelper: View {
    var tag: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.1), radius: 10)
            .padding()
            .overlay(
                Text(tag)
            )
    }
}

struct ContainerHelper_Previews: PreviewProvider {
    static var previews: some View {
        ContainerHelper(tag: "Airlines")
    }
}
