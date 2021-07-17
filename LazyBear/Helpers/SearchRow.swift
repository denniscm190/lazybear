//
//  SearchRow.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct SearchRow: View {
    var company: SearchModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(company.symbol!)")
                    .font(.headline)
                
                Text("\(company.securityName!)")
                    .font(.subheadline)
                    .opacity(0.5)
                    .lineLimit(1)
            }
            
            Spacer()
        }
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(company: SearchModel(symbol: "AAPL", securityName: "Apple Inc"))
    }
}
