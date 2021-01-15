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
            
            
        }
    }
    
    func cumulativeSum() -> [Double] {
        
        return [Double]()
    }
}

struct TransactionCharts_Previews: PreviewProvider {
    static var previews: some View {
        InsiderCharts(transaction: InsiderTransaction.init(), width: 100)
    }
}
