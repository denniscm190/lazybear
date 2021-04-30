//
//  CreateNewWatchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/4/21.
//

import SwiftUI

struct CreateNewWatchlist: View {
    @State private var showSearchView = false
    @ObservedObject var newWatchlistClass = NewWatchlistClass()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Watchlist name")) {
                    TextField("Technologies, banks", text: $newWatchlistClass.name)
                }
                
                Section(header: Text("Companies")) {
                    Button("Add companies", action: { showSearchView = true })
                    
                    ForEach(newWatchlistClass.companies, id: \.self) { company in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(company.symbol!.uppercased())
                                    .fontWeight(.semibold)

                                Text(company.securityName!.capitalized)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
            .navigationTitle("New watchlist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: {  })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {  })
                }
            }
        }
        .sheet(isPresented: $showSearchView) {
            SearchView(calledFromProfileView: true, newWatchlistClass: newWatchlistClass)
        }
    }
}

struct CreateNewWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewWatchlist()
    }
}
