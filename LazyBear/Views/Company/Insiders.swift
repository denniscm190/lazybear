//
//  Insiders.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/5/21.
//

import SwiftUI

struct Insiders: View {
    @ObservedObject var company: Company
    var symbol: String
    
    var body: some View {
        if company.showInsidersView {
            VStack {
                if let insiderSummary = company.insidersData.insiderRoster {
                    InsiderList(insiderSummary: insiderSummary)
                        .padding(.bottom)
                }
                
                if let transactions = company.insidersData.insiderTransactions {
                    TransactionList(transactions: transactions)
                }
            }
        } else {
            ProgressView()
                .onAppear {
                   let url = "https://api.lazybear.app/company/insiders/symbol=\(symbol)"
                    company.request(url, .initial, "insider")
                }
        }
    }
}

struct Insiders_Previews: PreviewProvider {
    static var previews: some View {
        Insiders(company: Company(), symbol: "aapl")
    }
}
