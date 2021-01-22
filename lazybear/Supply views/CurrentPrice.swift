//
//  CurrentPrice.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct CurrentPrice: View {
    @ObservedObject var latestPrice = LatestPrice()
    var body: some View {
        HStack {
            Text("320.30")
                .font(.headline)
                .padding(.trailing)
            
            Text("+1.67%")
                .foregroundColor(.green)
            
            Spacer()
            AddWatchlist()
        }
        .padding([.leading, .trailing])
        .onAppear {
            latestPrice.request(symbol: "AAPL", sandbox: true)
        }
    }
}

struct CurrentPrice_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPrice()
    }
}
