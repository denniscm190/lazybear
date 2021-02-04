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
    
    var views = ["Stock", "Insiders"]
    @State private var selectedView = 0
    
    var body: some View {
        VStack {
            CompanyHeader(name: self.name, symbol: self.symbol)
            TabView {
                // First view
                GeometryReader { geo in
                    ScrollView {
                        VStack(alignment: .leading) {
                            Stock(name: name, symbol: symbol, lineChartHeight: geo.size.height*0.2)
                                .padding(.bottom)
                            
                            
                        }
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    }
                }
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First")
                }.tag(0)
                
                // Second view
                ScrollView {
                    InsiderTransactions(symbol: symbol)
                }
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }.tag(1)
            }
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(name: "Apple Inc", symbol: "AAPL")
    }
}
