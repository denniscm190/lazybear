//
//  StockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI


struct StockRow: View {
    var listName: String
    var list: [String: QuoteModel]
    var intradayPrices: [String: [IntradayPriceModel]]?
    var addOnDelete: Bool

    @State private var showExtensiveList = false
    
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(listName)
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
                    ForEach(Array(list.keys.sorted()), id: \.self) { companySymbol in
                        StockItem(symbol: companySymbol, company: list[companySymbol]!, intradayPrices: intradayPrices?[companySymbol], orientation: .vertical)
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
        .sheet(isPresented: $showExtensiveList) {
            ExtensiveList(listName: listName, list: list, intradayPrices: intradayPrices, latestCurrencies: nil, addOnDelete: addOnDelete)
                .environment(\.managedObjectContext, self.moc)
            
        }
    }
}


struct StockRectangleRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(
            listName: "Gainers",
            list: ["AAPL": QuoteModel(changePercent: 0.03, companyName: "Apple Inc", latestPrice: 130.3)],
            intradayPrices: ["AAPL": [IntradayPriceModel(open: 130.2)]], addOnDelete: false
        )
    }
}
