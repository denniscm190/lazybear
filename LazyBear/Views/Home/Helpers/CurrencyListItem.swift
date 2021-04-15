//
//  CurrencyListItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/4/21.
//

import SwiftUI

struct CurrencyListItem: View {
    var currencySymbol: String
    var currency: CurrencyModel
    
    var body: some View {
        HStack {
            Text(currency.flag)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text("USD/\(currencySymbol)")
                    .font(.headline)
                
                Text(currency.name)
                    .font(.callout)
            }
            
            Spacer()
            Text("\(currency.rate, specifier: "%.2f")")
                .padding(.horizontal)
        }
    }
}

struct CurrencyRowItem_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListItem(currencySymbol: "AUD", currency: CurrencyModel(flag: "🇺🇸", name: "Australian dollar", rate: 1.3116))
    }
}
