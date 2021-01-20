//
//  InsiderDetail.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/1/21.
//

import SwiftUI

struct InsiderDetail: View {
    @State var transaction: InsiderTransactionModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Owner")) {
                    SectionBody(image: "person.fill", data: transaction.reporting_owner)
                }
                
                Section(header: Text("Date YYYY/MM/DD")) {
                    SectionBody(image: "calendar", data: transaction.transaction_date)
                }
                
                Section(header: Text("Securities transacted")) {
                    SectionBody(image: "number", data: String(transaction.number_securities_transacted))
                }
                
                Section(header: Text("Transaction type")) {
                    let data = transaction.transaction_type.components(separatedBy: "-")[1]
                    SectionBody(image: "dollarsing.circle", data: data)
                    SectionBody(image: "info.circle", data: "Type: " + transaction.transaction_type)
                }
                
            }
        }
    }
}

struct SectionBody: View {
    @State var image: String
    @State var data: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(data)
        }
    }
}

struct InsiderDetail_Previews: PreviewProvider {
    static var previews: some View {
        InsiderDetail(transaction: InsiderTransactionModel(acquisition_disposition: "A", transaction_date: "2020-01-01", reporting_owner: "steve jobs", transaction_type: "F-SomeStuff", number_securities_transacted: 12345))
    }
}
