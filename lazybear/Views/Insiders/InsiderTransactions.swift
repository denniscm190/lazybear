//
//  Insiders.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/2/21.
//

import SwiftUI

struct InsiderTransactions: View {
    var symbol: String
    @EnvironmentObject var apiAccess: ApiAccess
    
    // <--------- API Job --------->
    @State private var url = String() {
        didSet { request(url: url, model: [InsiderTransactionModel].self) { self.data = $0 } }}
    
    @State private var data = [InsiderTransactionModel]()
    // <--------- API Job --------->
    
    var body: some View {
        VStack {
            HStack {
                Text("Insider transactions")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding([.leading, .bottom])
                Spacer()
            }
            .onAppear { getUrl() }
            
            List {
                ForEach(data, id: \.self) { data in
                    TransactionRow(data: data)
                }
            }
        }
    }
    
    private func getUrl() {
        // 1 -> Sandbox / 2 -> Production
        let baseUrl = apiAccess.results[1].url ?? ""
        let token = apiAccess.results[1].key ?? ""
        let path = "/stable/stock/\(symbol)/insider-transactions?token="
        
        self.url = baseUrl + path + token
    }
}

struct InsiderTransactions_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTransactions(symbol: "aapl")
    }
}
