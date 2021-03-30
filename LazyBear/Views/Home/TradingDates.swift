//
//  TradingDate.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct TradingDates: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach((1..<10)) { index in
                        TradingDatesItem()
                    }
                }
                .padding()
            }
            .navigationTitle("Trading dates")
        }
    }
}

struct TradingDate_Previews: PreviewProvider {
    static var previews: some View {
        TradingDates()
    }
}
