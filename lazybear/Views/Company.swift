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
    @EnvironmentObject var apiAccess: ApiAccess
    
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
                                .environmentObject(self.apiAccess)
                            
                            News(symbol: symbol)
                                .environmentObject(self.apiAccess)
                        }
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    }
                }
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stock")
                }.tag(0)
                
                // Second view
                ScrollView {
                    InsiderTransactions(symbol: symbol)
                        .environmentObject(self.apiAccess)
                }
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Insiders")
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
