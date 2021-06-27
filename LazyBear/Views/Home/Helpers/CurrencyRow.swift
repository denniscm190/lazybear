//
//  CurrencyRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/4/21.
//

import SwiftUI

struct CurrencyRow: View {
    var latestCurrencies: [CurrencyModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Currencies")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding([.top, .horizontal])
                    
                    Text("Updated at 6:00 CET on every working day")
                        .font(.caption)
                        .opacity(0.5)
                        .padding(.horizontal)
                }
                
                Spacer()
                NavigationLink(destination: CurrencySheet(latestCurrencies: latestCurrencies)
                                .navigationTitle("Currencies")
                ) {
                    HStack {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                }
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(latestCurrencies, id: \.self) { currency in
                        CurrencyItem(currency: currency)
                    }
                }
                .padding()
            }
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(latestCurrencies: [CurrencyModel(symbol: "AUD", name: "Australian dollar", flag: "🇺🇸", rate: 1.3116)])
    }
}
