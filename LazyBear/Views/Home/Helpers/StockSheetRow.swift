//
//  StockSheetRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI
import StockCharts

struct StockSheetRow: View {
    var company: CompanyModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(company.symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(company.companyName.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.6)
                    .lineLimit(1)
            }
            
            Spacer()
            LineChartView(data: company.intradayPrices, dates: nil, hours: nil, dragGesture: false)
                .frame(width: 80)
                .padding(.vertical, 10)
                .padding(.horizontal)
            
            
            if let latestPrice = company.latestPrice, let changePercent = company.changePercent {
                VStack(alignment: .trailing) {
                    Text("\(latestPrice, specifier: "%.2f")")
                        .foregroundColor(changePercent < 0 ? .red: .green)
                        .fontWeight(.semibold)

                    Text("\(changePercent * 100, specifier: "%.2f")%")
                        .foregroundColor(changePercent < 0 ? .red: .green)
                        .font(.callout)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

struct StockSheetRow_Previews: PreviewProvider {
    static var previews: some View {
        StockSheetRow(company: CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3]))
    }
}
