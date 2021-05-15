//
//  CompanyHeader.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI

struct CompanyHeader: View {
    var symbol: String
    @Binding var showViewSelector: Bool
    
    var body: some View {
        HStack {
            Text(symbol.uppercased())
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: { showViewSelector = true }) {
                Text("Views ")
                Image(systemName: "chevron.down")
            }
        }
    }
}

struct CompanyHeader_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeader(symbol: "AAPL", showViewSelector: .constant(false))
    }
}
