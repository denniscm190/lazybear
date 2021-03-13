//
//  PriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct PriceView: View {
    var symbol: String
    var showVertical: Bool
    @State private var latestPrice = Float()
    @State private var changePercent = Double()
    @State private var negativeChange = false
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  // Set recurrent price request
    
    var body: some View {
        VStack {
            if showVertical {
                VStack(alignment: .trailing) {
                    Text("\(latestPrice, specifier: "%.2f")")
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    Text("\(changePercent*100, specifier: "%.2f")%")
                        .foregroundColor(negativeChange ? Color(.systemRed) : Color(.systemGreen))
                        .padding(.trailing)
                }
            } else {
                HStack {
                    Text("\(latestPrice, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    Text("\(changePercent*100, specifier: "%.2f")%")
                        .font(.headline)
                        .foregroundColor(negativeChange ? Color(.systemRed) : Color(.systemGreen))
                        .padding(.trailing)
                    
                    Spacer()
                }
            }
        }
        .onReceive(timer) { _ in call(); print("requested") }
        .onAppear {
            call()
            self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  // Restart timer
        }
        .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
    }
    
    private func call() {
        let url = getUrl(endpoint: .quote, symbol: symbol)
        request(url: url, model: PriceModel.self) { result in
            self.latestPrice = result.latestPrice
            if result.changePercent < 0 {
                self.negativeChange  = true
            }
            
            self.changePercent = result.changePercent
        }
    }
}


struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(symbol: "aapl", showVertical: false)
    }
}
