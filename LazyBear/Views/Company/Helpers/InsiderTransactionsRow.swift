//
//  InsiderTransactionsRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/6/21.
//

import SwiftUI

struct InsiderTransactionsRow: View {
    var insiderTransaction: InsiderTransactionModel
    
    var body: some View {
        HStack {
            VStack {
                let date = convertStringToDate(insiderTransaction.filingDate)
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
                Text(insiderTransaction.fullName.capitalized)
                    .lineLimit(1)
                    .font(.headline)
                
                if let reportedTitle = insiderTransaction.reportedTitle {
                    Text(reportedTitle.capitalized)
                }
            }
            
            Spacer()
            if let transactionShares = insiderTransaction.transactionShares {
                VStack(alignment: .trailing) {
                    Text("\(transactionShares)")
                        .foregroundColor(transactionShares < 0 ? Color(.systemRed): Color(.systemGreen))
                }
                .padding(.leading)
            }
        }
    }
}

struct InsiderTransactionsRow_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactionsRow(
            insiderTransaction:
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
