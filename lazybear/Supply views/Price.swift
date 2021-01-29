//
//  Price.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI
import CloudKit

struct Price: View {
    let iexApi = IexApi()
    
    var body: some View {
        Text("Price")
            .onAppear {
                //let url = api[1].url! as String
                //let token = api[1].key! as String
                //let path = iexApi.getURL(version: .stable, stock: .symbol(company: "AAPL"), endpoint: .quote, range: nil, parameters: nil)
                //let endpoint = url + path + token
                //print(endpoint)
            }
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Price()
    }
}
