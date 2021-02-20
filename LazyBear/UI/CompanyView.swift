//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyView: View {
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    @Environment(\.managedObjectContext) private var moc
    
    var name: String
    var symbol: String
    
    var body: some View {
        ScrollView {
            PriceView(symbol: symbol)
            NewsView(symbol: symbol)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Change view")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                let symbols = companies.map { $0.symbol }
                if !symbols.contains(symbol) {
                    Button(action: { add() }) {
                        Image(systemName: "star")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
    
    // Add to watchlist
    private func add() {
        let company = Company(context: moc)
        company.symbol = symbol
        company.name = name
        do {
            try moc.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompanyView(name: "apple inc", symbol: "aapl")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
