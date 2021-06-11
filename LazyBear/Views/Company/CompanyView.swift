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
    
    /*
     Views
     */
    @State private var showChartView = true
    @State private var showInsiderView = false
    
    var body: some View {
        ScrollView {
            VStack {
                CompanyHeader(symbol: symbol, showViewSelector: $showViewSelector)
                    .padding(.bottom)

                if showChartView {
                    Chart(company: company, symbol: symbol)
                } else if showInsiderView {
                    Insiders(company: company, symbol: symbol)
                }
            }
            .padding()
        }
        .actionSheet(isPresented: $showViewSelector) {
            ActionSheet(title: Text("Select an option"), buttons: [
                .default(Text("Chart & News")) { resetViews(); showChartView = true },
                .default(Text("Insiders")) { resetViews(); showInsiderView = true },
                .cancel()
            ])
        }
    }
    
    /*
     Hide all views to show the one selected by user
     */
    private func resetViews() {
        showChartView = false
        showInsiderView = false
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "AAPL")
    }
}
