//
//  InsiderTransactionsView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI

struct InsiderTransactionsView: View {
    var symbol: String
    var name: String
    @ObservedObject var company: Company
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct InsiderTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactionsView(symbol: "AAPL", name: "Apple Inc", company: Company())
    }
}
