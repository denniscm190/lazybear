//
//  KeyStatsRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/6/21.
//

import SwiftUI

struct KeyStatsRow: View {
    var label: String
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack {
            Text("\(label)")
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(1)
            
        }
        .padding()
        .background(
            Capsule()
                .frame(height: 40)
                .foregroundColor(Color("customSecondaryBackground"))
                .if(colorScheme == .light) { content in
                    content.shadow(color: Color(.systemGray).opacity(0.25), radius: 10, x: 0.0, y: 0.0)
                }
        )
    }
}

struct KeyStatsRow_Previews: PreviewProvider {
    static var previews: some View {
        KeyStatsRow(label: "Company Name")
    }
}
