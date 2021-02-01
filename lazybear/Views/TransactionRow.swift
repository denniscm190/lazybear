//
//  TransactionRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/2/21.
//

import SwiftUI

struct TransactionRow: View {
    @State var data: InsiderTransactionModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(data.fullName ?? "-".capitalized)
                        .fontWeight(.semibold)
                    
                    Text(data.transactionDate ?? "-")
                        .font(.subheadline)
                }
                Spacer()
                Text("$\(data.transactionValue ?? 0, specifier: "%.2f")")
                    .fontWeight(.semibold)
            }
            .padding([.leading, .trailing])
            
            Divider()
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(data: InsiderTransactionModel(
                                conversionOrExercisePrice: 100,
                                directIndirect: "D",
                                filingDate: "2020-10-09",
                                fullName: "Tim",
                                postShares: 100,
                                reportedTitle: "Some reported title",
                                transactionCode: "B",
                                transactionDate: "2020-10-09",
                                transactionPrice: 50,
                                transactionShares: 1000,
                                transactionValue: 50000)
        )
    }
}
