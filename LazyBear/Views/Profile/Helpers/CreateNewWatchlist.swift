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
    @State private var showCancelAlert = false
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    
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
                            
                            Spacer()
                            Button(action: { remove(company) }, label: {
                                Image(systemName: "multiply.circle")
                            })
                        }
                    }
                }
            }
            .navigationTitle("New watchlist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: { saveWatchlist(newWatchlistClass.companies) })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: { self.showCancelAlert = true })
                }
            }
        }
        // Show delete list alert
        .alert(isPresented: $showCancelAlert) {
            Alert(
                title: Text("Your watchlist won't be saved"),
                message: Text("This action can't be undo"),
                primaryButton: .destructive(Text("Exit")) { presentationMode.wrappedValue.dismiss() },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $showSearchView) {
            SearchView(calledFromProfileView: true, newWatchlistClass: newWatchlistClass)
                .environment(\.managedObjectContext, self.moc)
        }
    }
    
    /*
     Search company in array and get the index -> Delete company at
     this index from the array
     */
    private func remove(_ company: SearchResponse) {
        let index = newWatchlistClass.companies.firstIndex(of: company)
        newWatchlistClass.companies.remove(at: index!)
    }
    
    /*
     Save companies to Core Data and create watchlist
     */
    private func saveWatchlist(_ companies: [SearchResponse]) {
        for company in companies {
            let watchlistCompany = WatchlistCompany(context: moc)
            watchlistCompany.name = company.securityName ?? "-"
            watchlistCompany.symbol = company.symbol!
            watchlistCompany.watchlist = newWatchlistClass.name
        }
        
        do {
            try moc.save()
            print("Watchlist created")
            presentationMode.wrappedValue.dismiss()  // Dismiss view
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CreateNewWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewWatchlist()
    }
}
