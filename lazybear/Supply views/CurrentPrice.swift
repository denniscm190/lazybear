//
//  CurrentPrice.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct CurrentPrice: View {
    @State var price: Double
    @State var change: Double
    @State var marketIsOpen: Bool
    
    var body: some View {
        HStack {
            Text("\(price, specifier: "%.2f")")
                .font(.headline)
                .padding(.trailing)
            
            Text("\(change, specifier: "%.2f")%")
                .foregroundColor(.green)
            
            Spacer()
            AddWatchlist()
        }
        .padding([.leading, .trailing])
    }
}

struct CurrentPrice_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPrice(price: 100.50, change: 1.35, marketIsOpen: true)
    }
}
