//
//  CurrencyItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/4/21.
//

import SwiftUI

struct CurrencyItem: View {
    var currency: CurrencyModel
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color("customSecondaryBackground"))
            .if(colorScheme == .light) { content in
                content.shadow(color: Color(.systemGray).opacity(0.25), radius: 10, x: 0.0, y: 0.0)
            }
            .frame(width: 330, height: 50)
            .overlay(
                HStack {
                    Color(.systemBlue)
                        .frame(width: 40)
                        .overlay(
                            Text(currency.flag)
                        )
                    VStack(alignment: .leading) {
                        Text("USD/\(currency.symbol)")
                            .font(.headline)
                        
                        Text(currency.name)
                            .font(.callout)
                    }
                    
                    Spacer()
                    Text("\(currency.rate, specifier: "%.2f")")
                        .padding(.horizontal)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            )
    }
}

struct CurrencyItem_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyItem(currency: CurrencyModel(symbol: "AUD", name: "Australian dollar", flag: "🇺🇸", rate: 1.3116))
    }
}
