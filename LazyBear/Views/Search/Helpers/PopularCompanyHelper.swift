//
//  PopularCompanyHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI

struct PopularCompanyHelper: View {
    var company: CompanyQuoteModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 100)
            .overlay(
                HStack {
                     Rectangle()
                         .frame(width: 15)
                         .foregroundColor(Color("default"))
                    
                    VStack {
                        Text(company.companyName)
                        Text(company.symbol)
                    }
                    
                    Spacer()
                    
                    PriceView(latestPrice: company.latestPrice, changePercent: company.changePercent)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
            )
    }
}

struct PopularCompanyHelper_Previews: PreviewProvider {
    static var previews: some View {
        PopularCompanyHelper(company: CompanyQuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 120.30, changePercent: 0.03))
    }
}
