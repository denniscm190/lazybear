//
//  SettingRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct SettingRow: View {
    // Should pass @State because if not preview crashes
    @State var image: String
    @State var text: String
    @State var colour: UIColor
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.white)
                .padding(3)
                .background(Color(colour)
                                .cornerRadius(4)
                                .frame(width: 30, height: 30)
                )
            
            Text(text)
                .padding(.horizontal, 7)
        }
    }
}

struct SettingRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingRow(image: "at", text: "About", colour: .systemBlue)
    }
}
