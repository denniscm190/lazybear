//
//  Watchlist.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import CoreData

struct Watchlist: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.symbol, ascending: true)],
        animation: .default)
    private var companies: FetchedResults<Company>

    var body: some View {
        List {
            ForEach(companies) { company in
                NavigationLink(destination: CompanyView(symbol: company.symbol)) {
                    WatchlistRow(symbol: company.symbol)
                }
            }
            .onDelete(perform: deleteCompanyFromWatchlist)
        }
        .navigationTitle("Companies")
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }

    private func deleteCompanyFromWatchlist(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct Watchlist_Previews: PreviewProvider {
    static var previews: some View {
        Watchlist()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
