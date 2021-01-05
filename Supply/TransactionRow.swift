//
//  TransactionRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/1/21.
//

import SwiftUI

struct TransactionRow: View {
    var trans: TransactionModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                Text(trans.reporting_owner.capitalized)
                Spacer()
                Text(String(trans.number_securities_transacted))
                    .foregroundColor(colourShares(type: trans.acquisition_disposition))
            }
            HStack {
                Image(systemName: "calendar")
                Text(trans.transaction_date)
            }
        }
        .padding()
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
        TransactionRow(trans: TransactionModel(acquisition_disposition: "A", transaction_date: "2020-01-01", reporting_owner: "steve jobs", transaction_type: "F-SomeStuff", number_securities_transacted: 12345))
    }
}
