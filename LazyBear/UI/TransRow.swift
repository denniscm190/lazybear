//
//  InsiderRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct TransRow: View {
    var transaction: InsiderTranModel
    @State private var showingDetail = false
    @Environment(\.colorScheme) var colorScheme  // Detect dark mode
    
    var body: some View {
        Button(action: { self.showingDetail = true }) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(transaction.fullName?.capitalized ?? "-")
                        .fontWeight(.semibold)
                    
                    if let date = transaction.transactionDate {
                        Text(date)
                    }
                }
                
                Spacer()
                if let shares = transaction.transactionShares ?? 0 {
                    Text("\(shares)")
                        .foregroundColor(shares < 0 ? Color(.systemRed): Color(.systemGreen))
                        .fontWeight(.semibold)
                }
            }
        }
        .foregroundColor(colorScheme == .dark ? .white: .black)
        .sheet(isPresented: $showingDetail) {
            TranDetail(transaction: transaction)
        }
    }
}

struct TransRow_Previews: PreviewProvider {
    static var previews: some View {
        TransRow(transaction: InsiderTranModel(directIndirect: "D", transactionDate: "2020-02-04", fullName: "WAGNER SUSAN", postShares: 886126, transactionCode: "M", transactionPrice: 13.20, transactionShares: 12345, transactionValue: 123456.50))
    }
}
