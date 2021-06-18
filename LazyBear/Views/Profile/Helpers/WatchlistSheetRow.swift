//
//  WatchlistSheetRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/6/21.
//

import SwiftUI
import StockCharts
import CoreData

struct WatchlistSheetRow: View {
    var apiCompany: CompanyModel
    var watchlistCompany: WatchlistCompany
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(watchlistCompany.symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(watchlistCompany.name.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.6)
                    .lineLimit(1)
            }
            
            Spacer()
            LineChartView(data: apiCompany.intradayPrices, dates: nil, hours: nil, dragGesture: false)
                .frame(width: 80)
                .padding(.vertical, 10)
                .padding(.horizontal)
            
            
            if let latestPrice = apiCompany.latestPrice, let changePercent = apiCompany.changePercent {
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

struct WatchlistSheetRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let watchlistCompany = WatchlistCompany(context: moc)
        watchlistCompany.name = "apple inc"
        watchlistCompany.symbol = "aapl"
        watchlistCompany.watchlistName = "Default"
        
        return WatchlistSheetRow(
            apiCompany: CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3]),
            watchlistCompany: watchlistCompany
        )
    }
}
