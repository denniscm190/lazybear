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
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            Text(name.capitalized)
                                .font(.title)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Picker("", selection: $selectedRange) {
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
                        KeyStatsHelper(keyStats: company.data.keyStats)
                    }
                }
                .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
                .navigationTitle(symbol.uppercased())
            }
        } else {
            ProgressView()
                .onAppear {
                    company.request("https://api.lazybear.app/company/symbol=aapl", .initial)
                }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "aapl", name: "apple inc")
    }
}
