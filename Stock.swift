//
//  Stock.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/1/21.
//

import SwiftUI
import SwiftUICharts

struct Stock: View {
    @ObservedObject var price = Price()
    
    // Company
    @State var cik: Int
    @State var symbol: String
    @State var name: String

    var body: some View {
        GeometryReader { geo in
            VStack {
                if price.showingView {
                    HStack {
                        Text("$ " + String(price.result.last!.close))
                            .font(.title)
                            .fontWeight(.bold)
                        
                        let pct = price.result.last!.changePercent * 100
                        Text(String(format: "%.2f", pct) + " %")
                            .font(.headline)
                            .foregroundColor(whichColor())
                        
                        Spacer()
                    }
                    .padding([.leading, .top])
                    
                    HStack {
                        Text(String(price.result.last!.date) + " last price")
                            .font(.caption)
                            .padding([.leading])
                            .opacity(0.5)
                        Spacer()
                    }
                    
                    // Stock Price
                    let width = geo.size.height*0.6
                    let prices = price.result.map { $0.close }  // Get an array of a variable in the struct
                    LineChartView(data: prices, title: "Stock price", legend: "Last 20 days",  form: CGSize(width: width, height: width/2), rateValue: nil)
                        .padding()
                    
                    Spacer()
                    
                    // Volume
                    let volume = price.result.map { $0.volume }
                    BarChartView(data: ChartData(points: volume), title: "Volume", form: CGSize(width: width, height: width/2))
                        .padding()
                    
                }
                else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            .onAppear {
                price.request(symbol: symbol)
            }
            .alert(isPresented: $price.showingAlert) {
                        Alert(title: Text("There is no data available"), message: Text("We have no data about this company. Try another one."), dismissButton: .default(Text("Got it!")))
                    }
        }
    }
    
    func whichColor() -> Color {
        if price.result.last!.changePercent < 0 {
            return Color(.red)
        }
        else {
            return Color(.green)
        }
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock(cik: 123, symbol: "Symbol", name: "Name")
    }
}
