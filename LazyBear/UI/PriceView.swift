//
//  PriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct PriceView: View {
    var symbol: String
    
    var body: some View {
        Text("Price View")
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(symbol: "aapl")
    }
}
