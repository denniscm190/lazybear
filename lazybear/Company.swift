//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/12/20.
//

import SwiftUI

struct Company: View {
    // Company arguments
    var cik: Int
    var symbol: String
    var name: String
    
    @State public var showingInsiders: Bool = false
    @State public var showingStocks: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if showingStocks {
                    Stock(cik: cik, symbol: symbol, name: name)
                }
                else {
                    Insiders(cik: cik, symbol: symbol, name: name)
                }
                
                // Start bottom selection
                Rectangle()
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(height: geo.size.height * 0.1)
                    .overlay(
                        Selection(showingInsiders: $showingInsiders, showingStocks: $showingStocks)
                    )
            }
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(cik: 320193, symbol: "aapl", name: "apple inc")
    }
}
