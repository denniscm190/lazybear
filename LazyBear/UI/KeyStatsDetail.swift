//
//  KeyStatsDetail.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/3/21.
//

import SwiftUI

struct KeyStatsDetail: View {
    var keyStats: KeyStatsModel
    
    var body: some View {
        NavigationView {
            Form {
                FirstSection(keyStats: keyStats)
                SecondSection(keyStats: keyStats)
                ThirdSection(keyStats: keyStats)
            }
            .navigationTitle("Key statistics")
        }
    }
}

struct StatCell: View {
    var icon: String?
    var text: String
    var data: Any
    
    var body: some View {
        HStack {
            if let symbol = icon {
                Image(systemName: symbol)
            }
            Text(text)
                .font(.headline)
            if let numData = data as? Double {
                Text("\(numData, specifier: "%.2f")")
            } else if let stringData = data as? String {
                Text(stringData)
            }
        }
    }
}

struct FirstSection: View {
    var keyStats: KeyStatsModel
    
    var body: some View {
        Section(header: Text("About the company")) {
            if let employees = keyStats.Employees {
                StatCell(icon: nil, text: "Employees: ", data: employees)
            }
            if let marketCap = keyStats.Market_Cap {
                StatCell(icon: nil, text: "Market cap:", data: marketCap)
            }
            if let shares = keyStats.Shares {
                StatCell(icon: nil, text: "Shares outstanding: ", data: shares)
            }
        }
    }
}

struct SecondSection: View {
    var keyStats: KeyStatsModel
    
    var body: some View {
        Section(header: Text("About the stock")) {
            if let beta = keyStats.Beta {
                StatCell(icon: nil, text: "Beta: ", data: beta)
            }
            if let peRatio = keyStats.PE_Ratio {
                StatCell(icon: nil, text: "P/E Ratio: ", data: peRatio)
            }
            if let trailingEps = keyStats.Trailing_EPS {
                StatCell(icon: nil, text: "Trailing EPS: ", data: trailingEps)
            }
            if let dividendYield = keyStats.Dividend_Yield {
                StatCell(icon: nil, text: "Dividend yield in %: ", data: dividendYield*100)
            }
            if let nextDividendDate = keyStats.Next_Dividend_Date {
                StatCell(icon: nil, text: "Next dividend date: ", data: nextDividendDate)
            }
            if let trailingDividendRate = keyStats.Trailing_Dividend_Rate {
                StatCell(icon: nil, text: "Trailing dividend rate: ", data: trailingDividendRate)
            }
        }
    }
}

struct ThirdSection: View {
    var keyStats: KeyStatsModel
    
    var body: some View {
        Section(header: Text("Technical analysis")) {
            if let weeks52low = keyStats.Weeks52_Low {
                StatCell(icon: nil, text: "52 weeks low: ", data: weeks52low)
            }
            if let weeks52High = keyStats.Weeks52_High {
                StatCell(icon: nil, text: "52 weeks high: ", data: weeks52High)
            }
            if let days10AvgVolume = keyStats.Days10_Avg_Volume {
                StatCell(icon: nil, text: "10 days average volume: ", data: days10AvgVolume)
            }
            if let days30AvgVolume = keyStats.Days30_Avg_Volume {
                StatCell(icon: nil, text: "30 days average volume: ", data: days30AvgVolume)
            }
            if let days200MovingAvg = keyStats.Days200_Moving_Avg {
                StatCell(icon: nil, text: "200 days moving average: ", data: days200MovingAvg)
            }
            if let days50MovingAvg = keyStats.Days50_Moving_Avg {
                StatCell(icon: nil, text: "50 days moving average: ", data: days50MovingAvg)
            }
        }
    }
}

struct KeyStatsDetail_Previews: PreviewProvider {
    static var previews: some View {
        KeyStatsDetail(keyStats: KeyStatsModel(Market_Cap: 100000, Weeks52_High: 12, Weeks52_Low: 12, Shares: 13334434, Days10_Avg_Volume: 12, Days30_Avg_Volume: 12, Days200_Moving_Avg: 12, Days50_Moving_Avg: 12, Employees: 12345, Trailing_EPS: 12, Trailing_Dividend_Rate: 12, Dividend_Yield: 0.07, Next_Dividend_Date: "2020-02-02", PE_Ratio: 12, Beta: 12))
    }
}
