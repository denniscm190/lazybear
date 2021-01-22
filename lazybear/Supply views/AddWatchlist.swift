//
//  AddWatchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct AddWatchlist: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FavCompany.entity(), sortDescriptors: [])
    var favCompanies: FetchedResults<FavCompany>
    
    var body: some View {
        Button(action: {  }) {
            Text("Add to watchlist")
        }
    }
    
    func addWatchlist(cik: Int, symbol: String, name: String) {
        let favCompany = FavCompany(context: viewContext)
        favCompany.cik = Int32(cik)
        favCompany.symbol = symbol
        favCompany.name = name
        do {
            try viewContext.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AddWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        AddWatchlist()
    }
}
