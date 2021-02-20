//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct Watchlist: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(companies, id: \.self) { company in
                    NavigationLink(destination: CompanyView(name: company.name, symbol: company.symbol)) {
                        CompanyRow(symbol: company.symbol, name: company.name)
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
        try? moc.save()
    }
}

struct Watchlist_Previews: PreviewProvider {
    static var previews: some View {
        Watchlist()
    }
}
