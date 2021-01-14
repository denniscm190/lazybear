//
//  Stock.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/1/21.
//

import SwiftUI
import SwiftUICharts

struct Stock: View {
    // Company arguments
    var cik: Int
    var symbol: String
    var name: String
    
    @ObservedObject var price = Price()
    
    var body: some View {
        if price.showingView {
        GeometryReader { geo in
            VStack {
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
                .padding([.leading, .top, .trailing])
                    
                HStack {
                    Text(String(price.result.last!.date) + " last price")
                        .font(.caption)
                        .padding([.leading])
                        .opacity(0.5)
                    
                    Spacer()
                }
                
                // Stock Price
                let width = geo.size.width*0.9
                let prices = price.result.map { $0.close }  // Get an array of a variable in the struct
                ScrollView {
                    LineChartView(data: prices, title: "Stock price", legend: "Last 20 days",  form: CGSize(width: width, height: width/2), rateValue: nil)  // It has a minimum height
                        .padding()
                    
                    // Volume
                    let volume = price.result.map { $0.volume }
                    BarChartView(data: ChartData(points: volume), title: "Volume", form: CGSize(width: width, height: width/1.5))
                            .padding()
                    }
                }
            }
        }
        else {
            VStack{
                Spacer()
                ProgressView()
                Spacer()
            }
            .onAppear {
                print(symbol)
                price.request(symbol: symbol)
            }
            .alert(isPresented: $price.showingAlert) {
                        Alert(title: Text("There is no data available"),
                              message: Text("We have no data about this company. Try another one."),
                              dismissButton: .default(Text("Got it!")))
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
extension Image {
    func favouriteIcon() -> some View {
        self
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(.yellow)
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock(cik: 320193, symbol: "aapl", name: "apple inc")
    }
}
