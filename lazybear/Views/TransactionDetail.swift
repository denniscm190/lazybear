//
//  TransactionDetail.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct TransactionDetail: View {
    @State var data: InsiderTransactionModel
    @Environment(\.presentationMode) var transactionDetailPresentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filling date")) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(data.filingDate ?? "-")
                    }
                }
                
                Section(header: Text("Owner")) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(data.fullName ?? "-")
                    }
                    let title = data.reportedTitle ?? ""
                    if !title.isEmpty {
                        Text(data.reportedTitle ?? "")
                    }
                }
                
                let postShares = data.postShares ?? 0
                if postShares != 0 {
                    Section(header: Text("Shares owned after the transaction")) {
                        HStack {
                            Image(systemName: "number")
                            Text(String(postShares))
                        }
                    }
                }
                
                Section(header: Text("Transaction type")) {
                    let transactionCode = data.transactionCode ?? ""
                    Text(transactionCodes[transactionCode] ?? "-")
                }
                
                Section(header: Text("Transaction data")) {
                    let shares = Int(data.transactionShares ?? 0)
                    if shares != 0 {
                        Text("Number of shares: \(shares)")
                    }
                    let price = data.transactionPrice ?? 0
                    if price != 0 {
                        Text("Price per share: $\(price, specifier: "%.2f")")
                    }
                    let value = data.transactionValue ?? 0
                    if value != 0 {
                        Text("Transaction value: $\(value, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("Transaction detail")
        }
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetail(data: InsiderTransactionModel(
                            conversionOrExercisePrice: 100,
                            directIndirect: "D",
                            filingDate: "2020-10-09",
                            fullName: "Tim",
                            postShares: 100,
                            reportedTitle: "Some reported title",
                            transactionCode: "I",
                            transactionDate: "2020-10-09",
                            transactionPrice: 50,
                            transactionShares: 1000,
                            transactionValue: 50000))
    }
}
