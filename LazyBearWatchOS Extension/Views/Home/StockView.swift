//
//  StockView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI
import StockCharts

struct StockView: View {
    var symbol: String
    @ObservedObject var company: Company
    
    var body: some View {
        if company.showView {
                VStack(alignment: .leading) {
                    if let company = company.data.quote?.first {
                        Text(company.companyName)
                        
                        if let latestPrice = company.latestPrice {
                            Text("\(latestPrice, specifier: "%.2f")")
                                .foregroundColor(company.changePercent ?? 0.0 < 0 ? .red: .green)
                                .font(.title2)
                        }
                        
                        if let changePercent = company.changePercent {
                            Text("\(changePercent * 100, specifier: "%.2f")%")
                                .foregroundColor(changePercent < 0 ? .red: .green)
                        }
                        
                        if let prices = company.intradayPrices {
                            LineChartView(data: prices, dates: nil, hours: nil, dragGesture: false)
                                .padding(.top)
                        }
                        
                        Text("Real-time data")
                            .font(.footnote)
                            .opacity(0.7)
                    }
                }
        } else {
            ProgressView()
                .onAppear {
                    company.request("https://api.lazybear.app/individual/endpoint=quote/symbol=\(symbol)", .initial)
                }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(symbol: "AAPL", company: Company())
    }
}
