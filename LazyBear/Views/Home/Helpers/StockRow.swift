//
//  StockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI


struct StockRow: View {
    var list: [String: [String: QuoteModel]]
    var intradayPrices: [String: [Double]]?

    @State private var showList = false
    
    var body: some View {
        let listName = list.first!.key
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(adaptListTitle(listName))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding([.top, .horizontal])
                    
                    Text("Real-time quotes")
                        .font(.caption)
                        .opacity(0.5)
                        .padding(.horizontal)
                }
                
                Spacer()
                Button("See all", action: { showList = true })
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    let companies = list[listName]
                    ForEach(Array(companies!.keys), id: \.self) { symbol in
                        StockItem(symbol: symbol, company: companies![symbol]!, intradayPrices: intradayPrices![symbol])
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
        .sheet(isPresented: $showList) {
            StockSheet(listName: adaptListTitle(listName), companies: list[list.first!.key]!, intradayPrices: intradayPrices)
        }
    }
    
    /*
     Get list keys (mostactive, losers, active) and adapt them to diplay
     */
    private func adaptListTitle(_ title: String) -> String {
        if title == "mostactive" {
            return "Most active"
        } else {
            return title.capitalized
        }
    }
}


struct StockRectangleRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(
            list: ["mostactive": ["AAPL": QuoteModel(changePercent: 0.03, companyName: "Apple Inc", latestPrice: 130.3)]],
            intradayPrices: ["AAPL": [130.2]]
        )
    }
}
