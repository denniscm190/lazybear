//
//  Transactions.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct Transactions: View {
    var symbol: String
    @EnvironmentObject var apiAccess: ApiAccess
    
    // <--------- API Job --------->
    @State private var url = String() {
        didSet { request(url: url, model: [InsiderTransactionModel].self) { self.data = $0 } }}
    
    @State private var data = [InsiderTransactionModel]()
    // <--------- API Job --------->
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Insider transactions")
                .font(.title)
                .fontWeight(.semibold)
                .padding([.leading, .bottom])
            
            List {
                ForEach(data, id: \.self) { data in
                    TransactionRow(data: data)
                }
            }
        } .onAppear { getUrl() }
    }
    
    private func getUrl() {
        let baseUrl = apiAccess.results[apiAccess.option].url ?? ""
        let token = apiAccess.results[apiAccess.option].key ?? ""
        let path = "/stable/stock/\(symbol)/insider-transactions?token="
        
        self.url = baseUrl + path + token
    }
}

struct Transactions_Previews: PreviewProvider {
    static var previews: some View {
        Transactions(symbol: "aapl")
    }
}
