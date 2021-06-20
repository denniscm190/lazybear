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
                        
                        ChartHelper(quote: company.data.quote, historicalPrices: company.data.historicalPrices)
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
