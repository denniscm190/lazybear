//
//  TransactionCharts.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI
import Charts

struct InsiderCharts: View {
    @State var transaction: InsiderTransaction
    @State var width: CGFloat

    
    var body: some View {
        VStack {
            PieChart(dataPoints: dataPoints())
                .shadow(radius: 10)
        }
    }
    
    func dataPoints() -> [DataPoint] {
        var buys = [Int]()
        var sells = [Int]()
        for trans in transaction.result {
            if trans.acquisition_disposition == "A" {
                // It's a buy
                buys.append(trans.number_securities_transacted)
            }
            else {
                // It's a sell
                sells.append(trans.number_securities_transacted)
            }
        }
        
        // Now add up all the securities transacted
        let totalBuys = buys.reduce(0, +)
        let totalSells = sells.reduce(0, +)
        
        // Finally return DataPoint for PieChart
        var PieData: [DataPoint] {
            [
                DataPoint(id: 1, value: Double(totalBuys), color: .red),
                DataPoint(id: 1, value: Double(totalSells), color: .green),
            ]
        }
        
        return PieData
    }
}

struct TransactionCharts_Previews: PreviewProvider {
    static var previews: some View {
        InsiderCharts(transaction: InsiderTransaction.init(), width: 100)
    }
}
