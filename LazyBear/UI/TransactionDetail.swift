//
//  TransactionDetail.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/3/21.
//

import SwiftUI

struct TransactionDetail: View {
    var transaction: InsiderTranModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Insider information")) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(transaction.fullName?.capitalized ?? "-")
                    }
                    
                    if let postShares = transaction.postShares {
                        HStack {
                            Image(systemName: "number")
                            Text("\(postShares) shares owned")
                        }
                    }
                }
                
                Section(header: Text("Transaction information")) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(transaction.transactionDate ?? "-")
                    }
                    
                    let direcIndirect = transaction.directIndirect ?? "-"
                    if direcIndirect == "D" {
                        Text("Direct transaction")
                    } else if direcIndirect == "I" {
                        Text("Indirect transaction")
                    }
                    
                    if let tranPrice = transaction.transactionPrice {
                        Text(String(format: "Price per share: $%.2f", tranPrice))
                    }
                    
                    if let tranShares = transaction.transactionShares {
                        Text("Shares transacted: \(tranShares)")
                    }
                    
                    if let tranValue = transaction.transactionValue {
                        Text(String(format: "Transaction value: $%.2f", tranValue))
                    }
                }
                
                if let tranType = transactionCodes[transaction.transactionCode ?? "-"] {
                    Section(header: Text("Transaction type")) {
                        Text(tranType)
                    }
                }
            }
            .navigationTitle("Transaction detail")
        }
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetail(transaction: InsiderTranModel(directIndirect: "D", transactionDate: "2020-02-04", fullName: "WAGNER SUSAN", postShares: 886126, transactionCode: "M", transactionPrice: 13.20, transactionShares: 12345, transactionValue: 123456.50))
    }
}
