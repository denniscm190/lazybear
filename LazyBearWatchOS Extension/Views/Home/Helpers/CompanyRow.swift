//
//  CompanyRow.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 22/6/21.
//

import SwiftUI

struct CompanyRow: View {
    var company: CompanyModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(company.symbol.uppercased())
                    .font(.caption2)
                    .fontWeight(.semibold)
                
                Spacer()
                if let changePercent = company.changePercent {
                    VStack {
                        Text("\(changePercent * 100, specifier: "%.2f")%")
                            .foregroundColor(changePercent < 0 ? .red: .green)
                    }
                }
            }
            
            if let latestPrice = company.latestPrice {
                Text("\(latestPrice, specifier: "%.2f")")
                    .foregroundColor(company.changePercent ?? 0.0 < 0 ? .red: .green)
                    .font(.title2)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(company.changePercent ?? 0.0 < 0 ? .red: .green)
                .opacity(0.2)
        )
    }
}

struct CompanyRow_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(company:
            CompanyModel(
                symbol: "aapl",
                companyName: "Apple Inc",
                latestPrice: 120.3,
                changePercent: 0.03,
                intradayPrices: [120.3]
            )
        )
    }
}
