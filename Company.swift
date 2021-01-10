//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/12/20.
//

import SwiftUI

struct Company: View {
    @State public var showingInsiders: Bool = false
    @State public var showingMain: Bool = true
    
    // Company
    @State var cik: Int
    @State var symbol: String
    @State var name: String
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if showingMain {
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
                        Selection(showingInsiders: $showingInsiders, showingMain: $showingMain)
                    )
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(cik: 123, symbol: "Symbol", name: "Name")
    }
}
