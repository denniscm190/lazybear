//
//  Row.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct Row: View {
    var baseText: String
    var subText: String?
    var lefView: AnyView?
    var rightView: AnyView?
    
    var body: some View {
        HStack {
            lefView
            VStack(alignment: .leading) {
                Text(baseText.uppercased())
                    .fontWeight(.semibold)
                
                Text(subText?.capitalized ?? "")
                    .lineLimit(1)
            }
            
            Spacer()
            rightView
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(baseText: "aapl", subText: "apple inc")
    }
}
