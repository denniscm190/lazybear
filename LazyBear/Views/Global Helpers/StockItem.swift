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
    var symbol: String
    var company: QuoteModel
    var intradayPrices: [IntradayPriceModel]?
    var orientation: OrientationView
    var hidePriceView: Bool?
    
    var body: some View {
        if orientation == .vertical {
            return AnyView(VerticalStockRow(symbol: symbol, company: company, intradayPrices: intradayPrices))
        } else {
            return AnyView(HorizontalStockRow(symbol: symbol, company: company, intradayPrices: intradayPrices, hidePriceView: hidePriceView ?? false))
        }
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(
            symbol: "AAPL", company: QuoteModel(changePercent: 0.03, companyName: "apple inc", latestPrice: 130.3),
            intradayPrices: [IntradayPriceModel(open: 130.3), IntradayPriceModel(open: 132.3)], orientation: .horizontal
        )
    }
}


struct VerticalStockRow: View {
    var symbol: String
    var company: QuoteModel
    var intradayPrices: [IntradayPriceModel]?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.secondarySystemBackground))
            .aspectRatio(0.8, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                VStack(alignment: .leading) {
                    Group {
                        Text(symbol.uppercased())
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
    var symbol: String
    var company: QuoteModel
    var intradayPrices: [IntradayPriceModel]?
    var hidePriceView: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(company.companyName.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.6)
                    .lineLimit(1)
            }
            
            Spacer()
            if !hidePriceView {
                if let prices = intradayPrices?.compactMap { $0.open } {
                    LineView(data: prices)
                        .foregroundColor(company.changePercent < 0 ? .red: .green)
                        .frame(width: 80)
                        .padding(.vertical, 10)
                        .padding(.leading)
                }
                
                PriceView(latestPrice: company.latestPrice, changePercent: company.changePercent, align: .trailing)
                    // Center PriceView with the other rows
                    .frame(minWidth: 80, alignment: .trailing)
            }
        }
        .padding(5)
    }
}
