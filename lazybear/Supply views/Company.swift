//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct Company: View {
    var name: String
    var symbol: String
    
    var body: some View {
        CompanyHeader(name: self.name, symbol: self.symbol)
        ScrollView {
            VStack(alignment: .leading) {
                //Stock(name: self.name, symbol: self.symbol)
                Spacer()
            }
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(name: "Apple Inc", symbol: "AAPL")
    }
}
