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
    
    var body: some View {
        NavigationView {
            TabView {
                GeometryReader { geo in
                    ScrollView {
                        VStack(alignment: .leading) {
                            Stock(name: name, symbol: symbol, lineChartHeight: geo.size.height*0.2)
                                .padding(.bottom)
                            
                            News(symbol: symbol)
                        }
                    }
                }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Stock")
            }
        }
        .navigationBarTitle(symbol, displayMode: .inline)
        .navigationBarItems(
            leading:
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "multiply")
                }
            ,
            trailing:
                AddWatchlist(symbol: symbol, name: name)
        )
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company(name: "Apple Inc", symbol: "AAPL")
    }
}
