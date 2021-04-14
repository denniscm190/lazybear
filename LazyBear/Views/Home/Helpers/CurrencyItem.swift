//
//  CurrencyItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/4/21.
//

import SwiftUI

struct CurrencyItem: View {
    var currencySymbol: String
    var currency: CurrencyModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(width: 330, height: 50)
            .overlay(
                HStack {
                    Color("default")
                        .frame(width: 40)
                        .overlay(
                            Text(currency.flag)
                        )
                    VStack(alignment: .leading) {
                        Text(currencySymbol)
                            .font(.headline)
                        
                        Text(currency.name)
                            .font(.callout)
                    }
                    
                    Spacer()
                    Text("$ \(currency.rate, specifier: "%.2f")")
                        .padding(.horizontal)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            )
    }
}

struct CurrencyItem_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyItem(currencySymbol: "AUD", currency: CurrencyModel(flag: "🇺🇸", name: "Australian dollar", rate: 1.3116))
    }
}
