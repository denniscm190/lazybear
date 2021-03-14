//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import CoreData

struct Watchlist: View {
    @EnvironmentObject var hudManager: HudManager
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(companies, id: \.symbol) { company in
                    let index = companies.firstIndex(of: company)
                    let name = company.name
                    let symbol = company.symbol
                    NavigationLink(destination: CompanyView(name: name, symbol: symbol)
                                    .navigationTitle(symbol)
                    ) {
                        CompanyRow(symbol: symbol, name: name, rowNumber: index! % 5, showPrice: true)
                    }
                }
                .onDelete(perform: removeCompany)
            }
            .navigationTitle("Watchlist 👀")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
        Watchlist()
    }
}
