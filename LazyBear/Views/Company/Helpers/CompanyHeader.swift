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
            
            Button("Views", action: { showViewSelector = true })
        }
    }
}

struct CompanyHeader_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeader(symbol: "AAPL", showViewSelector: .constant(false))
    }
}
