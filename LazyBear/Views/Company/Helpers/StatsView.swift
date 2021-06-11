//
//  StatsView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 9/6/21.
//

import SwiftUI

struct StatsView: View {
    var keyStats: KeyStatsModel
    
    @Environment(\.presentationMode) private var presentationStatsView
    
    let displayWords: DisplayWordsModel = parseJSON("DisplayWords.json")
    
    var body: some View {
        NavigationView {
            Form {
                let mirror = Mirror(reflecting: keyStats)
                ForEach(Array(mirror.children), id: \.label) { child in  /// Iterate over each variable within the class
                    if let unwrappedValue = unwrapAnyOptional(value: child.value) {
                        HStack {
                            let label = String(child.label!)
                            Text("\(displayWords.keyStats[label]!):")
                                .font(.callout)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Text(unwrappedValue)
                                .font(.callout)
                        }
                    }
                }
            }
            .navigationTitle("Key statistics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationStatsView.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
    
    /*
     Unwrap optional Int, Double, String into String
     */
    private func unwrapAnyOptional(value: Any) -> String? {
        if let value = value as? Int {
            return "\(value)"
        } else if let value = value as? Double {
            return String(format: "%.3f", value)
        } else {
            return value as? String
        }
    }
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(keyStats:
                KeyStatsModel(
                    companyName: "Apple inc",
                    employees: 123,
                    marketcap: 123,
                    float: 123,
                    sharesOutstanding: 123,
                    beta: 123.12,
                    peRatio: 123.4,
                    dividendYield: 123.4,
                    ttmDividendRate: 123.4,
                    ttmEPS: 123.4,
                    avg10Volume: 123,
                    avg30Volume: 123,
                    day50MovingAvg: 123.4,
                    day200MovingAvg: 123.4,
                    week52Change: 123.4,
                    week52High: 123.4,
                    week52Low: 123.4,
                    week52HighSplitAdjustOnly: 123.4,
                    week52LowSplitAdjustOnly: 123.4,
                    maxChangePercent: 123.4,
                    ytdChangePercent: 123.4,
                    day5ChangePercent: 123.4,
                    day30ChangePercent: 123.4,
                    month1ChangePercent: 123.4,
                    month3ChangePercent: 123.4,
                    month6ChangePercent: 123.4,
                    year1ChangePercent: 123.4,
                    year2ChangePercent: 123.4,
                    year5ChangePercent: 123.4,
                    exDividendDate: "2020-01-01",
                    nextDividendDate: "2020-01-01",
                    nextEarningsDate: "2020-01-01"
            )
        )
    }
}
