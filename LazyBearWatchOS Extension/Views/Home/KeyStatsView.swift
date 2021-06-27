//
//  KeyStatsView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI

struct KeyStatsView: View {
    var symbol: String
    var name: String
    @ObservedObject var company: Company
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct KeyStatsView_Previews: PreviewProvider {
    static var previews: some View {
        KeyStatsView(symbol: "AAPL", name: "Apple Inc", company: Company())
    }
}
