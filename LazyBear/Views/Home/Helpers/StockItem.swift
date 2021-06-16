//
//  StockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI
import StockCharts

struct StockItem: View {
    var company: CompanyModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.secondarySystemBackground))
            .aspectRatio(0.8, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                VStack(alignment: .leading) {
                    Group {
                        Text(company.symbol.uppercased())
                            .fontWeight(.semibold)
                            .padding(.top)
                        
                        Text(company.companyName.capitalized)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .opacity(0.6)
                            .lineLimit(1)
                        
                        if let latestPrice = company.latestPrice, let changePercent = company.changePercent {
                            VStack(alignment: .leading) {
                                Text("\(latestPrice, specifier: "%.2f")")
                                    .foregroundColor(changePercent < 0 ? .red: .green)
                                    .fontWeight(.semibold)

                                Text("\(changePercent * 100, specifier: "%.2f")%")
                                    .foregroundColor(changePercent < 0 ? .red: .green)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                            }
                            .padding(.top)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                     
                    LineChartView(data: company.intradayPrices, dates: nil, hours: nil, dragGesture: false)
                        .padding(.vertical)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                ,alignment: .leading
            )
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(company: CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3]))
    }
}
