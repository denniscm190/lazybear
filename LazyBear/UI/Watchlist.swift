//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import CoreData

struct Watchlist: View {
    @ObservedObject var hudManager: HUDManager
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    
    var body: some View {
        NavigationView {
            // Iterate over and over through this list to print the color for every row
            // Color names are from 1 to 5
            let colorNumber = ["1", "2", "3", "4", "5"]
            List {
                ForEach(companies.indices) { i in
                    let name = companies[i].name
                    let symbol = companies[i].symbol
                    NavigationLink(destination: CompanyView(hudManager: hudManager, name: name, symbol: symbol)
                                    .navigationTitle(symbol)
                    ) {
                        // Pass color number to the row
                        CompanyRow(symbol: symbol, name: name, rowNumber: i % colorNumber.count)
                    }
                }
                .onDelete(perform: removeCompany)
            }
            .navigationTitle("Watchlist 👀")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func removeCompany(at offsets: IndexSet) {
        for index in offsets {
            let company = companies[index]
            moc.delete(company)
        }
        do {
            try moc.save()
        } catch {
            // Error
        }
    }
}

struct Watchlist_Previews: PreviewProvider {
    static var previews: some View {
        Watchlist(hudManager: HUDManager())
    }
}
