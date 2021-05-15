//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI
import StockCharts

struct CompanyView: View {
    var symbol: String
    
    @ObservedObject var company = Company()
    @State private var showViewSelector = false
    
    // Views
    @State private var showChartView = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CompanyHeader(symbol: symbol, showViewSelector: $showViewSelector)
                    
                    // Chart View
                    if showChartView {
                        Chart(company: company, symbol: symbol)
                    }
                }
                .padding()
            }
            .navigationTitle("Apple inc")
            .navigationBarTitleDisplayMode(.inline)
        }
        .actionSheet(isPresented: $showViewSelector) {
            ActionSheet(title: Text("Select an option"), buttons: [
                .default(Text("Chart & News")) { showChartView = true },
                .cancel()
            ])
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "AAPL")
    }
}
