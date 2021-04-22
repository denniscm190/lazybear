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
    var addOnDelete: Bool
    
    @Environment(\.presentationMode) private var extensiveListPresent
    @State var isEditMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            VStack {
                if let list = list {
                    List {
                        ForEach(Array(list.keys.sorted()), id: \.self) { companySymbol in
                                StockItem(symbol: companySymbol,
                                          company: list[companySymbol]!,
                                          intradayPrices: intradayPrices?[companySymbol],
                                          orientation: .horizontal,
                                          hidePriceView: self.isEditMode == .active  // Hide on EditMode
                                )
                            
                        }
                        .onDelete(perform: addOnDelete ? removeCompany: nil)
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
                ToolbarItem(placement: .navigationBarLeading) {
                    if addOnDelete {
                        EditButton()
                    }
                }
            }
            .environment(\.editMode, self.$isEditMode)  // Always after Toolbar
        }
    }
    private func removeCompany(at offsets: IndexSet) {
        print("Hello")
    }
}

struct ExtensiveList_Previews: PreviewProvider {
    static var previews: some View {
        ExtensiveList(listName: "List name", addOnDelete: false)
    }
}
