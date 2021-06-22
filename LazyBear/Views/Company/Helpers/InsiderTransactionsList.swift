//
//  InsiderTransactionsList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/6/21.
//

import SwiftUI

struct InsiderTransactionsList: View {
    var insiderTransactions: [InsiderTransactionModel]
    @Environment(\.presentationMode) private var insiderTransactionsListPresentation
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(insiderTransactions, id: \.self) { insiderTransaction in
                        InsiderTransactionsRow(insiderTransaction: insiderTransaction)
                        Divider()
                    }
                }
                .padding()
            }
            .navigationTitle("Insider Transactions")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { insiderTransactionsListPresentation.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
}

struct InsiderTransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactionsList(
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
