//
//  TransactionRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/2/21.
//

import SwiftUI

struct TransactionRow: View {
    @State var data: InsiderTransactionModel
    @State private var showingDetail = false
    
    var body: some View {
        Button(action: { self.showingDetail.toggle() }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(data.fullName?.capitalized ?? "-")
                        .fontWeight(.semibold)
                    
                    Text(data.transactionDate ?? "-")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(data.transactionShares ?? 0)")
                        .fontWeight(.semibold)
                        .foregroundColor(color())
                    
                    Text("Shares")
                        .font(.subheadline)
                }
            }
        }
        .sheet(isPresented: $showingDetail) {
            TransactionDetail(data: self.data)
        }
    }
    
    private func color() -> Color {
        var color: Color = .red
        if data.transactionShares ?? 0 >= 0 {
            color = .green
        }
        
        return color
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
