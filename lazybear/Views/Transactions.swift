//
//  Transactions.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct Transactions: View {
    var symbol: String
    @EnvironmentObject var apiManager: ApiManager
    
    // API job variables
    @State private var url = String() {
        didSet { request(url: url, model: [InsiderTransactionModel].self) { self.data = $0 } }}
    
    @State private var data = [InsiderTransactionModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Insiders")
                .fontWeight(.semibold)
                .modifier(Title())
            
            List {
                Section(header: Text("Transactions")) {
                    ForEach(data, id: \.self) { data in
                        TransactionRow(data: data)
                    }
                }
            }
        } .onAppear { getUrl() }
    }
    
    // Create endpoint
    private func getUrl() {
        let baseUrl = apiManager.results[apiManager.option].url ?? ""
        let token = apiManager.results[apiManager.option].key ?? ""
        let path = "/stable/stock/\(symbol)/insider-transactions?token="
        
        self.url = baseUrl + path + token
    }
}

struct Transactions_Previews: PreviewProvider {
    static var previews: some View {
        Transactions(symbol: "aapl")
    }
}
