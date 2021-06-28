//
//  InsiderTransactionsHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/6/21.
//

import SwiftUI

struct InsiderTransactionsHelper: View {
    var insiderTransactions: [InsiderTransactionModel]
    @State private var showList = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Insider Transactions")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                NavigationLink(destination: InsiderTransactionsList(insiderTransactions: insiderTransactions)
                                .navigationTitle("Insider Transactions")
                                .navigationBarTitleDisplayMode(.large)
                ) {
                    Text("See all")
                        .accentColor(Color.blue)
                }
            }
            .padding(.bottom)
            
            ForEach(insiderTransactions.prefix(4), id: \.self) { insiderTransaction in
                InsiderTransactionsRow(insiderTransaction: insiderTransaction)
                Divider()
            }
        }
        .padding()
        .background(
            CustomRectangleBox()
        )
    }
}

struct InsiderTransactionsHelper_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactionsHelper(
            insiderTransactions:
                [
                    InsiderTransactionModel(
                        filingDate: "2020-01-01",
                        fullName: "Dennis Concepcion",
                        postShares: 1234,
                        reportedTitle: "Director",
                        transactionCode: "S",
                        transactionPrice: 20.08,
                        transactionShares: 12345,
                        transactionValue: 1234567.0
                    )
                ]
        )
    }
}
