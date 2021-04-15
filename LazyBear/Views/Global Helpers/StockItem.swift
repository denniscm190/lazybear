//
//  StockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

enum OrientationView {
    case horizontal, vertical
}

struct StockItem: View {
    var company: QuoteModel
    var intradayPrices: [IntradayPricesModel]?
    var orientation: OrientationView
    
    var body: some View {
        if orientation == .vertical {
            return AnyView(VerticalStockRow(company: company, intradayPrices: intradayPrices))
        } else {
            return AnyView(HorizontalStockRow(company: company, intradayPrices: intradayPrices))
        }
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(
            company: QuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 130.3, changePercent: 0.03),
            intradayPrices: [IntradayPricesModel(open: 130.3), IntradayPricesModel(open: 132.3)], orientation: .horizontal
        )
    }
}


struct VerticalStockRow: View {
    var company: QuoteModel
    var intradayPrices: [IntradayPricesModel]?
    
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
                        
                        PriceView(latestPrice: company.latestPrice, changePercent: company.changePercent, align: .leading)
                            .padding(.top)
                            
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                     
                    if let prices = intradayPrices?.compactMap { $0.open } {
                        LineView(data: prices)
                            .foregroundColor(company.changePercent < 0 ? .red: .green)
                            .padding(.vertical)
                            .clipped()
                    }
                        
                }
                ,alignment: .leading
            )
    }
}


struct HorizontalStockRow: View {
    var company: QuoteModel
    var intradayPrices: [IntradayPricesModel]?
    
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
            if let prices = intradayPrices?.compactMap { $0.open } {
                LineView(data: prices)
                    .foregroundColor(company.changePercent < 0 ? .red: .green)
                    .frame(width: 80)
                    .padding(.vertical, 10)
                    .padding(.leading)
            }
            
            PriceView(latestPrice: company.latestPrice, changePercent: company.changePercent, align: .trailing)
                // Avoid moving LineView along the HStack when numbers increases
                .frame(minWidth: 80, alignment: .trailing)
        }
        .padding(5)
    }
}
