//
//  StockStats.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/1/21.
//

import SwiftUI

struct StockStats: View {
    @State var data: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.white)
            .overlay(Text(String(data)))
            .frame(maxWidth: 360)
            .padding()
    }
}

struct StockStats_Previews: PreviewProvider {
    static var previews: some View {
        StockStats(data: "500.00")
    }
}
