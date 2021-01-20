//
//  TransactionRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/1/21.
//

import SwiftUI

struct TransactionRow: View {
    @State var transaction: InsiderTransactionModel
    @State var showingDetails = false
    
    var body: some View {
        Button(action: { self.showingDetails.toggle() }) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.fill")
                    Text(transaction.reporting_owner.capitalized)
                    Spacer()
                    Text(String(transaction.number_securities_transacted))
                        .foregroundColor(colourShares(type: transaction.acquisition_disposition))
                }
                HStack {
                    Image(systemName: "calendar")
                    Text(transaction.transaction_date)
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingDetails) {
            InsiderDetail(transaction:
                            InsiderTransactionModel(
                                acquisition_disposition: transaction.acquisition_disposition,
                                transaction_date: transaction.transaction_date,
                                reporting_owner: transaction.reporting_owner,
                                transaction_type: transaction.transaction_type,
                                number_securities_transacted: transaction.number_securities_transacted)
            )
        }
    }
    
    func colourShares(type: String) -> Color {
        if type == "A" {  // If aquisition_disposition == A, means "Acquisition" -> buy
            return Color(.green)
        }
        else {
            return Color(.red)
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: InsiderTransactionModel(acquisition_disposition: "A", transaction_date: "2020-01-01", reporting_owner: "steve jobs", transaction_type: "F-SomeStuff", number_securities_transacted: 12345))
    }
}
