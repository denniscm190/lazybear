//
//  TransactionList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI

struct TransactionList: View {
    @State var transaction: InsiderTransaction
    
    var body: some View {
        List {
            ForEach(transaction.result, id:\.self) { trans in
                TransactionRow(trans: trans)
            }
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList(transaction: InsiderTransaction.init())
    }
}
