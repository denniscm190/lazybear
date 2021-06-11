//
//  TransactionRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: InsiderTransactionModel
    
    var body: some View {
        RowShape()
            .frame(height: 105)
            .overlay(
                HStack {
                    VStack {
                        let date = convertStringToDate(transaction.filingDate)
                        Text(getDateComponents(.month, date))
                            .fontWeight(.semibold)
                        
                        Text(getDateComponents(.day, date))
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                        
                        Text(getDateComponents(.year, date))
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text(transaction.fullName.capitalized)
                            .lineLimit(1)
                            .font(.headline)
                        
                        Text(transaction.reportedTitle?.capitalized ?? "-")
                    }
                    
                    Spacer()
                    if let transactionShares = transaction.transactionShares {
                        VStack(alignment: .trailing) {
                            Text("\(transactionShares)")
                                .foregroundColor(transactionShares < 0 ? Color(.systemRed): Color(.systemGreen))
                        }
                        .padding(.leading)
                    }
                }
                .padding()
            )
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction:
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
        )
    }
}
