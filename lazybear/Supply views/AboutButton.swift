//
//  AboutButton.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

struct AboutButton: View {
    @State var image: String
    @State var name: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .frame(width: 25, height: 25)
            
            Text(name)
        }
    }
}

struct AboutButton_Previews: PreviewProvider {
    static var previews: some View {
        AboutButton(image: "sparkles", name: "What's new")
    }
}
