//
//  CurrencySheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI

struct CurrencySheet: View {
    var latestCurrencies: [CurrencyModel]
    @Environment(\.presentationMode) private var currencySheetPresentation
    
    var body: some View {
        NavigationView {
            VStack {
                List(latestCurrencies, id: \.self) { currency in
                    CurrencySheetRow(currency: currency)
                }
            }
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {currencySheetPresentation.wrappedValue.dismiss()}) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
}

struct CurrencySheet_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySheet(latestCurrencies: [CurrencyModel(symbol: "AUD", name: "Australian dollar", flag: "🇦🇺", rate: 1.2938)])
    }
}
