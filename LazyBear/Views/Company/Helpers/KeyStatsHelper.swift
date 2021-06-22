//
//  KeyStatsHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct KeyStatsHelper: View {
    var keyStats: KeyStatsModel?
    let displayWords: DisplayWordsModel = parseJSON("DisplayWords.json")
    @State private var showList = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        if let keyStats = keyStats {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    
                    let mirror = Mirror(reflecting: keyStats)
                    ForEach(Array(mirror.children), id: \.label) { child in  /// Iterate over each variable within the class
                        
                        if let unwrappedValue = unwrapAnyOptional(value: child.value) {
                            let label = String(child.label!)
                            
                            Button(action: { showList = true }) {
                                Capsule()
                                    .frame(width: 250, height: 40)
                                    .foregroundColor(Color("customSecondaryBackground"))
                                    .if(colorScheme == .light) { content in
                                        content.shadow(color: Color(.systemGray).opacity(0.25), radius: 10, x: 0.0, y: 0.0)
                                    }
                                    .overlay(
                                        HStack {
                                            Text("\(displayWords.keyStats[label]!):")
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)
                                            
                                            Spacer()
                                            Text(unwrappedValue)
                                                .font(.callout)
                                                .lineLimit(1)
                                        }
                                        .padding()
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(height: 70)
                .padding(.horizontal)
            }
            .sheet(isPresented: $showList) {
                KeyStatsList(keyStats: keyStats, isPresented: $showList)
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

struct KeyStatsHelper_Previews: PreviewProvider {
    static var previews: some View {
        KeyStatsHelper(keyStats:
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
