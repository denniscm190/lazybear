//
//  TopStockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockItem: View {
    var company: CompanyRowModel
    var intradayPricesArray: IntradayPricesArray
    
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
                            
                            Text("$\(company.latestPrice, specifier: "%.2f")")
                                .foregroundColor(company.changePercent < 0 ? .red: .green)
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("\(company.changePercent*100, specifier: "%.2f")%")
                                .foregroundColor(company.changePercent < 0 ? .red: .green)
                                .fontWeight(.semibold)
                                
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                         
                        let prices = intradayPricesArray.intradayPrices.compactMap { $0.open }
                        // Compact Map will return an array without the nil values
                        LineView(data: prices)
                            .foregroundColor(company.changePercent < 0 ? .red: .green)
                            .padding(.vertical)
                            .clipped()
                            
                    }
                )
    }
}

struct TopStockItem_Previews: PreviewProvider {
    static var previews: some View {
        TopStockItem(company: CompanyRowModel(symbol: "aapl", companyName: "apple inc", latestPrice: 120.30, changePercent: 0.03), intradayPricesArray: IntradayPricesArray(intradayPrices: [IntradayPricesModel(open: 120.00)]))

    }
}
