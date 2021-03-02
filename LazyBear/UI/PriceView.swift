//
//  PriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct PriceView: View {
    var symbol: String
    @State private var latestPrice = Float()
    @State private var changePercent = Double()
    @State private var negativeChange = false
    
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  // Set recurrent price request
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(latestPrice, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text("\(changePercent*100, specifier: "%.2f")%")
                    .font(.headline)
                    .foregroundColor(negativeChange ? Color(.systemRed) : Color(.systemGreen))
                    .padding(.trailing)
                
                IexAttribution(text: "IEX Cloud")
                Spacer()
            
            }
            
        }
        .onReceive(timer) { _ in call(); print("requested") }
        .onAppear {
            call()
            self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  // Restart timer
        }
        .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/quote?token=\(apiKey)"

        return url
    }
    
    private func call() {
        request(url: getUrl(), model: PriceModel.self) { result in
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
        PriceView(symbol: "aapl")
    }
}
