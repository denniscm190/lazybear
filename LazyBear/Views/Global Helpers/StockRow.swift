//
//  StockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI


struct StockRow: View {
    var listName: String
    var list: [QuoteModel]
    var nestedIntradayPrices: [String: NestedIntradayPricesModel]?
    
    @State private var showExtensiveList = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(adaptTitle(listName))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding([.top, .horizontal])
                    
                    Text("Real-time quotes")
                        .font(.caption)
                        .opacity(0.5)
                        .padding(.horizontal)
                }
                
                Spacer()
                Button("See all", action: { self.showExtensiveList = true })
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(list, id: \.self) { company in
                        if let intradayPrices = nestedIntradayPrices?[company.symbol.uppercased()] {
                            StockItem(company: company, intradayPrices: intradayPrices.nestedIntradayPrices, orientation: .vertical)
                        } else {
                            StockItem(company: company, intradayPrices: nil, orientation: .vertical)
                        }
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
        .sheet(isPresented: $showExtensiveList) {
            ExtensiveList(listName: adaptTitle(listName), list: list, nestedIntradayPrices: nestedIntradayPrices, latestCurrencies: nil)
        }
    }
}

private func adaptTitle(_ listType: String) -> String {
    if listType == "mostactive" {
        return "Most active"
    } else {
        return listType.capitalized
    }
}


struct StockRectangleRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(
            listName: "mostactive",
            list: [QuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 130.3, changePercent: 0.03)],
            nestedIntradayPrices: ["AAPL": NestedIntradayPricesModel(nestedIntradayPrices: [IntradayPricesModel(open: 130.3)])]
        )
    }
}
