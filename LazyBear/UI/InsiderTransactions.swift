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
                    Text("Latest transactions")
                        .font(.title)
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
            let url = getUrl(endpoint: .insiderTransactions, symbol: symbol)
            request(url: url, model: [InsiderTranModel].self) { self.transactions = $0 }
        }
    }
}

struct InsiderTransactions_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactions(symbol: "aapl")
    }
}
