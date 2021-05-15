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
    @ObservedObject var viewSelector = ViewSelector()
    @State private var showViewSelector = false
    
    // Set recurrent price request
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CompanyHeader(symbol: symbol, showViewSelector: $showViewSelector)
                    
                    // <--- Chart View --->
                    if viewSelector.views["chart"]! {
                        let url = "https://api.lazybear.app/company/chart/type=init/symbol=\(symbol)"
                        
                        if company.showChartView {
                            Chart(chartData: company.chartData, symbol: symbol)
                                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  // Start timer
                                .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
                                .onReceive(timer) { _ in
                                    let url = "https://api.lazybear.app/company/chart/type=streaming/symbol=\(symbol)"
                                    company.request(url, isInitRequest: false, "chart") }  // Receive timer notification
                        }
                        else {
                            ProgressView()
                                .onAppear { company.request(url, isInitRequest: true, "chart") } }
                        
                        // ---> Chart View <---
                    }
                }
                .padding()
            }
            .navigationTitle("Apple inc")
            .navigationBarTitleDisplayMode(.inline)
        }
        .actionSheet(isPresented: $showViewSelector) {
            ActionSheet(title: Text("Select an option"), buttons: [
                .default(Text("Chart & News")) { viewSelector.showView(.chart) }, 
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
