//
//  CompanyRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyRow: View {
    var symbol: String
    var name: String
    var lefView: AnyView?
    var rightView: AnyView?
    
    var body: some View {
        HStack {
            lefView
            VStack(alignment: .leading) {
                Text(symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(name.capitalized)
                    .lineLimit(1)
            }
            
            Spacer()
            rightView
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(symbol: "aapl", name: "apple inc")
    }
}
