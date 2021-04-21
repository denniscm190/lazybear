//
//  ExtensiveList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/4/21.
//

import SwiftUI

struct ExtensiveList: View {
    var listName: String
    var list: [String: QuoteModel]?
    var intradayPrices: [String: [IntradayPriceModel]]?
    var latestCurrencies: [String: CurrencyModel]?
    
    @Environment(\.presentationMode) var extensiveListPresent
    
    var body: some View {
        NavigationView {
            VStack {
                if let list = list {
                    List(Array(list.keys.sorted()), id: \.self) { companySymbol in
                        StockItem(symbol: companySymbol, company: list[companySymbol]!, intradayPrices: intradayPrices?[companySymbol], orientation: .horizontal)
                    }
                }
                
                if let latestCurrencies = latestCurrencies {
                    List(Array(latestCurrencies.keys.sorted()), id: \.self) { currencySymbol in
                        CurrencyListItem(currencySymbol: currencySymbol, currency: latestCurrencies[currencySymbol]!)
                    }
                }
            }
            .navigationTitle(listName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { extensiveListPresent.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct ExtensiveList_Previews: PreviewProvider {
    static var previews: some View {
        ExtensiveList(listName: "List name")
    }
}
