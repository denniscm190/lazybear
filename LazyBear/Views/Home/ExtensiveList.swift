//
//  ExtensiveList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/4/21.
//

import SwiftUI

struct ExtensiveList: View {
    // General argument
    var listName: String
    
    // Arguments for lists
    var list: [QuoteModel]?
    var nestedIntradayPrices: [String: NestedIntradayPricesModel]?
    
    // Arguments for currencies
    var latestCurrencies: [String: CurrencyModel]?
    
    @Environment(\.presentationMode) var extensiveListPresent
    
    var body: some View {
        NavigationView {
            VStack {
                if let list = list {
                    List(list, id: \.self) { company in
                        Text(company.companyName)
                    }
                }
                
                if let latestCurrencies = latestCurrencies {
                    List(Array(latestCurrencies.keys), id: \.self) { currencySymbol in
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
