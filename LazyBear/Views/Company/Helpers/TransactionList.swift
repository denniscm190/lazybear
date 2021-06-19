//
//  TransactionList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

struct TransactionList: View {
    var transactions: [InsiderTransactionModel]
    
    @State private var showFullList = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Latest transactions")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                Button("See all", action: { showFullList = true })
            }
        
            VStack(alignment: .leading, spacing: 20) {
                ForEach(transactions.prefix(3), id: \.self) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
        }
        .sheet(isPresented: $showFullList) {
            TransactionFullList(transactions: transactions)
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList(transactions:
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

struct TransactionFullList: View {
    var transactions: [InsiderTransactionModel]
    @Environment(\.presentationMode) private var transactionFullListPresentation
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(transactions, id: \.self) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
                .padding()
            }
            .navigationTitle("Latest transactions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { transactionFullListPresentation.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}
