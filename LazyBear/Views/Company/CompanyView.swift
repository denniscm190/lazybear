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
    
    // Date picker
    var ranges = ["1D", "5D", "1M", "3M", "6M", "1Y", "5Y"]
    @State private var selectedRange = "Red"
    
    @ObservedObject var viewSelector = ViewSelector()
    @State private var showViewSelector = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CompanyHeader(symbol: symbol, showViewSelector: $showViewSelector)
                    DatePicker(ranges: ranges, selectedRange: $selectedRange)
                    Chart()
                }
                .padding()
            }
            .navigationTitle("Apple inc")
            .navigationBarTitleDisplayMode(.inline)
        }
        .actionSheet(isPresented: $showViewSelector) {
            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                .default(Text("Chart")) { viewSelector.showView(.chart) }, 
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
