//
//  Price.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI
import CloudKit

struct Price: View {
    @State var symbol: String
    @State var showVertical: Bool
    
    @State private var url = String() { didSet { requestPrice() }}
    @State private var showingView = false
    
    @State var latestPrice = Float()
    @State var changePercent = Double() { didSet { self.showingView = true }}
    @State private var negativeChange = false
    
    let iexApi = IexApi()  // Request api function
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()  // Set recurrent price request
    
    @EnvironmentObject var apiAccess: ApiAccess
    
    var body: some View {
        VStack(alignment: .trailing) {
            if self.showingView {
                Group {
                    Text("\(latestPrice, specifier: "%.2f")")
                        .fontWeight(.semibold)

                    Text("\(changePercent*100, specifier: "%.2f")%")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .background(Color(negativeChange ? .red : .green).cornerRadius(5))
                }
                .if(showVertical) { content in
                        HStack { content }
                    }
            }
        }
        .onAppear { getUrl() }
        //.onReceive(timer) { _ in giveMePrices() }
        .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
    }
    
     private func getUrl() {
        let baseUrl = apiAccess.results[1].url ?? ""  // 1 -> Sandbox / 2 -> Production
        let token = apiAccess.results[1].key ?? ""
        let path = iexApi.getPath(version: .stable, stock: .symbol(company: symbol), endpoint: .quote, range: nil, parameters: nil)
        
        self.url = baseUrl + path + token

    }
    
    private func requestPrice() {
        iexApi.request(url: url, model: QuoteModel.self) { result in
            self.latestPrice = result.latestPrice
            if self.changePercent >= 0 { self.negativeChange = true }
            self.changePercent = result.changePercent
        }
    }
}
// Wrap content if some condition is satisfied
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Price(symbol: "AAPL", showVertical: false)
    }
}
