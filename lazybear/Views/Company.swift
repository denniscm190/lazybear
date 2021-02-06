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
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading) {
                    Stock(name: name, symbol: symbol, lineChartHeight: geo.size.height*0.2)
                        .padding(.bottom)
                    
                    News(symbol: symbol)
                }
                .onAppear { saveSearch(name: name, symbol: symbol) }
            }
        }
        .navigationBarTitle(symbol, displayMode: .large)
        .navigationBarItems(trailing: AddWatchlist(symbol: symbol, name: name))
    }
    
    private func saveSearch(name: String, symbol: String) {
        let searched = RecentSearch(context: viewContext)
        searched.name = name
        searched.symbol = symbol
        searched.date = Date()
        do {
            try viewContext.save()
            print("Search saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(name: "Apple Inc", symbol: "AAPL")
    }
}
