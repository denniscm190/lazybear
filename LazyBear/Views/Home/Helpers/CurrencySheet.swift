//
//  CurrencySheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI

struct CurrencySheet: View {
    @Environment(\.presentationMode) private var currencySheetPresentation
    
    var latestCurrencies: [String: CurrencyModel]
    var body: some View {
        NavigationView {
            VStack {
                List(Array(latestCurrencies.keys.sorted()), id: \.self) { currencySymbol in
                    CurrencySheetRow(currencySymbol: currencySymbol, currency: latestCurrencies[currencySymbol]!)
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
        CurrencySheet(latestCurrencies: ["AUD": CurrencyModel(flag: "🇦🇺", name: "Australian dollar", rate: 1.2938)])
    }
}
