//
//  CurrencySheetRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI

struct CurrencySheetRow: View {
    var currency: CurrencyModel
    
    var body: some View {
        HStack {
            Text(currency.flag)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text("USD/\(currency.symbol)")
                    .font(.headline)
                
                Text(currency.name)
                    .font(.callout)
            }
            
            Spacer()
            Text("\(currency.rate, specifier: "%.2f")")
                .fontWeight(.semibold)
                .padding(.horizontal)
        }
    }
}

struct CurrencySheetRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySheetRow(currency: CurrencyModel(symbol: "AUD", name: "Australian dollar", flag: "🇦🇺", rate: 1.2938))
    }
}
