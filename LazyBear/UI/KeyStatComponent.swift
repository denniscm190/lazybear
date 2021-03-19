//
//  KeyStatComponent.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/3/21.
//

import SwiftUI

enum CustomStatLabel {
    
}

struct KeyStatComponent: View {
    var text: String
    var data: Any
    
    var body: some View {
        HStack {
            let cleanText = text.replacingOccurrences(of: "_", with: " ")
            Text(cleanText)
                .font(.caption)
                .fontWeight(.semibold)
            
            // Check type of data
            if let dataString = data as? String {
                if dataString.isEmpty {
                    Text("-")
                        .font(.caption)
                } else {
                Text(dataString)
                    .font(.caption)
                }
            } else if let dataNumber = data as? Double {
                Text("\(dataNumber, specifier: "%.2f")")
                    .font(.caption)
            }
        }
        .padding(10)
        .background(
            Capsule()
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0).opacity(0.3)
        )
    }
}

struct KeyStatComponent_Previews: PreviewProvider {
    static var previews: some View {
        KeyStatComponent(text: "Market cap", data: 123456.00)
    }
}
