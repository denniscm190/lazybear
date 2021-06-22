//
//  ChartHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI
import StockCharts

struct ChartHelper: View {
    @ObservedObject var company: Company
    
    var body: some View {
        CustomRectangleBox()
            .frame(height: 270)
            .overlay(
                VStack {
                    if let quote = company.data.quote?.first {
                        Text("\(quote.latestPrice ?? 0, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(quote.changePercent ?? 0 < 0 ? .red: .green)
                            .padding(.top)

                        HStack {
                            Text("\(quote.changePercent ?? 0 * 100, specifier: "%.2f")%")
                                .foregroundColor(quote.changePercent ?? 0 < 0 ? .red: .green)
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                            Text("1 day")
                                .font(.caption)
                                .opacity(0.5)
                        }
                        .padding(.horizontal)
            
                        Spacer()
                        
                        
                        if let historicalPrices = company.data.historicalPrices {
                            let prices = historicalPrices.compactMap { $0.close }
                            let dates = historicalPrices.compactMap { $0.date }
                            if company.showChart {
                                LineChartView(data: prices, dates: dates, hours: nil, dragGesture: true)
                                    .padding(.bottom)
                            } else {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer()
                }
            )
            .padding(.horizontal)
    }
}

struct ChartHelper_Previews: PreviewProvider {
    static var previews: some View {
        ChartHelper(company: Company())
    }
}
