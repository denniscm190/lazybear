//
//  SearchedCompanyItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct SearchedCompanyItem: View {
    var company: SearchResponse
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(company.symbol!.uppercased())
                    .fontWeight(.semibold)

                Text(company.securityName!.capitalized)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(company.currency!)
                    .fontWeight(.semibold)
                
                Text(company.region!)
            }
        }
    }
}

struct CompanyRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchedCompanyItem(company: SearchResponse(currency: "USD", region: "US", securityName: "apple inc", symbol: "aapl"))
    }
}
