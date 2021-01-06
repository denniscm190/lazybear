//
//  Insiders.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/1/21.
//

import SwiftUI
import SwiftUICharts

struct Insiders: View {
    @ObservedObject var transaction = Transaction()
    
    // Company
    @State var cik: Int
    @State var symbol: String
    @State var name: String
    
    // Picker
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }
    
    @State private var selectedDate = Date().addingTimeInterval(-6*30*24*60*60)  // month*days*hours*minutes*seconds
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if transaction.showingView {
                    // Graph
                    let cumBuys = cumSum(array: getTransactions(acquisitionOrDisposition: "A"))
                    let cumSells = cumSum(array: getTransactions(acquisitionOrDisposition: "D"))
                    let green = GradientColor(start: .green, end: .green)
                    let red = GradientColor(start: .red, end: .red)
                    
                    let width = geo.size.height*0.6
                    MultiLineChartView(data: [(cumBuys, green), (cumSells, red)], title: "Buys and sells", form: CGSize(width: width, height: width/2.3), rateValue: pct(buy: cumBuys.last!, sell: cumSells.last!))
                        .padding()
                
                    DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) { Text("Transactions since").font(.headline) }
                        .padding([.leading, .top, .trailing])
                        .onChange(of: self.selectedDate, perform: { date in
                            transaction.request(cik: String(cik), date: dateFormatter.string(from: selectedDate))
                        })

                    List {
                        ForEach(transaction.result, id:\.self) { trans in
                            TransactionRow(trans: trans)
                        }
                    }
                    .offset(y: 10)
                }
                else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            .onAppear {
                transaction.request(cik: String(cik), date: dateFormatter.string(from: selectedDate))
            }
            .alert(isPresented: $transaction.showingAlert) {
                        Alert(title: Text("There is no data available"), message: Text("We have no data about this company. Try another one."), dismissButton: .default(Text("Got it!")))
                    }
        }
    }
    // Function to sum an array and return a cumulative sum array
    func cumSum(array: [Double]) -> [Double] {
        var iterateArray = [Double]()
        var cumSumArray = [Double]()
        for value in array {
            iterateArray.append(value)
            cumSumArray.append(iterateArray.reduce(0, +))
        }
        return cumSumArray
    }
    // Return two arrays with buys and sells
    func getTransactions(acquisitionOrDisposition: String) -> [Double] {
        var result = [Double]()
        
        for trans in transaction.result {
            if trans.acquisition_disposition == acquisitionOrDisposition {
                result.append(Double(trans.number_securities_transacted))
            }
        }

        return result
    }
    // Get pct of net buys over sells
    func pct(buy: Double, sell: Double) -> Int {
        let pctOfBuys = buy / (buy+sell)
        let pctOfSells = sell / (buy+sell)
        let pct = pctOfBuys - pctOfSells
        
        return Int(pct*100)
    }
}

struct Insiders_Previews: PreviewProvider {
    static var previews: some View {
        Insiders(cik: 123, symbol: "Symbol", name: "Name")
    }
}
