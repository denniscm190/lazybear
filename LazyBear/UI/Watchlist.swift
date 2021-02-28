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
            List {
                ForEach(companies, id: \.self) { company in
                    NavigationLink(destination: CompanyView(hudManager: hudManager, name: company.name, symbol: company.symbol)
                                    .navigationTitle(company.symbol)
                    ) {
                        CompanyRow(symbol: company.symbol, name: company.name, rowNumber: 1)
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
