//
//  CompanyView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI

struct CompanyView: View {
    var symbol: String
    var name: String
    
    @ObservedObject var company = Company()
    
    var body: some View {
        List {
            NavigationLink(destination: StockView(symbol: symbol, company: company)
                            .navigationTitle(name.capitalized)
            ) {
                Label("Stock Price", systemImage: "chart.bar")
            }
            
            NavigationLink(destination: LatestNewsView(symbol: symbol, name: name, company: company)
                            .navigationTitle(name.capitalized)
            ) {
                Label("Latest News", systemImage: "newspaper")
            }
            
            NavigationLink(destination: KeyStatsView(symbol: symbol, name: name, company: company)
                            .navigationTitle(name.capitalized)
            ) {
                Label("Key Stats", systemImage: "chart.pie")
            }
            
            NavigationLink(destination: TopInsidersView(symbol: symbol, name: name, company: company)
                            .navigationTitle(name.capitalized)
            ) {
                Label("Top Insiders", systemImage: "person")
            }
            
            NavigationLink(destination: InsiderTransactionsView(symbol: symbol, name: name, company: company)
                            .navigationTitle(name.capitalized)
            ) {
                Label("Transactions", systemImage: "creditcard.circle")
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "AAPL", name: "Apple Inc")
            .navigationTitle("Apple Inc")
    }
}
