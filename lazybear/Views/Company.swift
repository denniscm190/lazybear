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
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        CompanyHeader(name: self.name, symbol: self.symbol)
        ScrollView {
            VStack(alignment: .leading) {
                Stock(name: name, symbol: symbol)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(name: "Apple Inc", symbol: "AAPL")
    }
}
