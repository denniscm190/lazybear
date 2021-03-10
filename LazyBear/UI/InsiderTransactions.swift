//
//  InsiderTransactions.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct InsiderTransactions: View {
    var symbol: String
    @State private var transactions = [InsiderTranModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            if !transactions.isEmpty {
                HStack {
                    Image(systemName: "dollarsign.square.fill")
                        .foregroundColor(Color(.systemGreen))
                        .imageScale(.large)
                    
                    Text("Latest transactions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            ForEach(transactions.reversed(), id: \.self) { trans in
                TransactionRow(transaction: trans)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                Divider()
           }
        }
        .onAppear {
            request(url: getUrl(), model: [InsiderTranModel].self) { self.transactions = $0 }
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/insider-transactions?token=\(apiKey)"

        return url
    }
}

struct InsiderTransactions_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactions(symbol: "aapl")
    }
}
