//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct CompanyView: View {
    var symbol: String
    var name: String
    
    @ObservedObject var company = Company()
    
    var ranges = ["1D", "5D", "1M", "3M", "6M", "1Y", "5Y"]  /// DatePicker ranges
    @State private var selectedRange = "3M"  /// Selected DatePicker range
    
    var body: some View {
        if company.showView {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text(name.capitalized)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(1)

                        Spacer()
                    }
                    .padding(.horizontal)

                    Picker("Select a range", selection: $selectedRange) {
                        ForEach(ranges, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: selectedRange, perform: { range in
                        let url = "https://api.lazybear.app/company/symbol=\(symbol)/type=refresh/range=\(range.lowercased())"
                        company.request(url, .refresh)
                    })
                    
                    ChartHelper(company: company)
                    if let keyStats = company.data.keyStats {
                        KeyStatsHelper(keyStats: keyStats)
                    }

                    if let latestNews = company.data.latestNews {
                        NewsHelper(latestNews: latestNews)
                            .padding([.horizontal, .bottom])
                    }
                    
                    if let insiderRoster = company.data.insiderRoster {
                        InsiderRosterHelper(insiderRoster: insiderRoster)
                            .padding([.horizontal, .bottom])
                    }

                    if let insiderTransactions = company.data.insiderTransactions {
                        InsiderTransactionsHelper(insiderTransactions: insiderTransactions)
                            .padding([.horizontal, .bottom])
                    }
                }
            }
            .background(Color("customBackground").edgesIgnoringSafeArea(.all))
        } else {
            ProgressView()
                .onAppear {
                    company.request("https://api.lazybear.app/company/symbol=\(symbol)", .initial)
                }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "aapl", name: "apple inc")
    }
}
