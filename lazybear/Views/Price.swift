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
    @EnvironmentObject var apiAccess: ApiAccess
    
    // <--------- API Job --------->
    @State private var showingView = false
    @State private var url = String() { didSet { requestPrice() }}
    @State private var data = [QuoteModel]() { didSet { self.showingView = true }}
    // <--------- API Job --------->
    
    // Set recurrent price request. Real-time prices
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .trailing) {
            if self.showingView {
                Group {
                    Text("\(data[0].latestPrice ?? 0, specifier: "%.2f")")
                        .fontWeight(.semibold)
                    
                    let percent = (data[0].changePercent ?? 0) * 100
                    Text("\(percent, specifier: "%.2f")%")
                        .padding(1)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .background(percentageColor().cornerRadius(3))

                }
                .if(showVertical) { content in
                        HStack { content }
                    }
            }
        }
        .onAppear { getUrl() }
        //.onReceive(timer) { _ in requestPrice() }
        .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
    }
    
     private func getUrl() {
        // 1 -> Sandbox / 2 -> Production
        let baseUrl = apiAccess.results[2].url ?? ""
        let token = apiAccess.results[2].key ?? ""
        let path = "/stable/stock/\(symbol)/quote?token="
        
        self.url = baseUrl + path + token

    }
    
    private func requestPrice() {
        request(url: url, model: QuoteModel.self) { result in
            self.data = [QuoteModel(latestPrice: result.latestPrice, changePercent: result.changePercent)]
        }
    }
    
    private func percentageColor() -> Color {
        var color: Color = .red
        if data[0].changePercent ?? 0 >= 0 {
            color = .green
        }
        
        return color
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
