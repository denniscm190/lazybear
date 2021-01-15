//
//  Insiders.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/1/21.
//

import SwiftUI
import SwiftUICharts

struct Insiders: View {
    var cik: Int
    var symbol: String
    var name: String
    
    @ObservedObject var transaction = InsiderTransaction()
    
    // Picker
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }
    
    @State private var selectedDate = Date().addingTimeInterval(-6*30*24*60*60)  // month*days*hours*minutes*seconds
    
    var body: some View {
        if transaction.showingView {
            GeometryReader { geo in
                VStack {
                    let width = geo.size.height*0.6
                    InsiderCharts(transaction: transaction, width: width)
                    
                    DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) { Text("Transactions since").font(.headline) }
                        .padding([.leading, .top, .trailing])
                        .onChange(of: self.selectedDate, perform: { date in
                            transaction.request(cik: String(cik), date: dateFormatter.string(from: selectedDate))
                        })

                    TransactionList(transaction: transaction)
                        .offset(y: 10)
                }
            }
        }
        else {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .onAppear {
                transaction.request(cik: String(cik), date: dateFormatter.string(from: selectedDate))
            }
            .alert(isPresented: $transaction.showingAlert) {
                        Alert(title: Text("There is no data available"),
                              message: Text("We have no data about this company. Try another one."),
                              dismissButton: .default(Text("Got it!")))
            }
        }
    }
}

struct Insiders_Previews: PreviewProvider {
    static var previews: some View {
        Insiders(cik: 320193, symbol: "aapl", name: "apple inc")
    }
}
