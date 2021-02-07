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
    @State var viewSelected = 0
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    
    var body: some View {
        VStack {
            if viewSelected == 0 {
                StockAndNews(name: name, symbol: symbol)
            } else if viewSelected == 1 {
                Transactions(symbol: symbol)
            }
        }
        .onAppear { saveSearch(name: name, symbol: symbol) }
        
        .navigationBarTitle(symbol, displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                CreateButton(symbol: symbol, name: name)
                    .padding(.trailing)
                
                Spacer()
                ViewSelector(viewSelected: $viewSelected)
            }
        )
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
