//
//  WatchlistCreator.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/4/21.
//

import SwiftUI

struct WatchlistCreator: View {
    @ObservedObject var watchlistCreatorClass = WatchlistCreatorClass()
    @State private var showSearchView = false
    @State private var showCancelAlert = false
    @State private var watchlistNameIsEmpty = false
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Watchlist name")) {
                    TextField("Technologies, banks", text: $watchlistCreatorClass.name)
                }
                
                Section(header: Text("Companies")) {
                    Button("Add companies", action: { showSearchView = true })
                    
                    ForEach(watchlistCreatorClass.companies, id: \.self) { company in
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
                                    .imageScale(.large)
                            })
                        }
                    }
                }
            }
            .navigationTitle("New watchlist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: { save() })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: { self.showCancelAlert = true })
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
        }
        // Show alert when watchlist name is empty
        .alert(isPresented: $watchlistNameIsEmpty) {
            Alert(
                title: Text("Give a name to your new watchlist"),
                message: Text("Try My portfolio, Favourites, ..."),
                dismissButton: .default(Text("Got it!"))
            )
        }
        .sheet(isPresented: $showSearchView) {
            WatchlistCreatorList(watchlistCreatorClass: watchlistCreatorClass)
                .environment(\.managedObjectContext, self.moc)
        }
    }
    
    /*
     Search company in array and get the index -> Delete company at
     this index from the array
     */
    private func remove(_ company: SearchResponse) {
        let index = watchlistCreatorClass.companies.firstIndex(of: company)
        watchlistCreatorClass.companies.remove(at: index!)
    }
    
    /*
     Check if the watchlist name is empty when the user taps the Done button.
     If it's not empty -> Save watchlist to Core Data
     */
    private func save() {
        if watchlistCreatorClass.name.isEmpty  {
            watchlistNameIsEmpty = true
        } else {
            for company in watchlistCreatorClass.companies {
                let watchlistCompany = WatchlistCompany(context: moc)
                watchlistCompany.name = company.securityName ?? "-"
                watchlistCompany.symbol = company.symbol!
                watchlistCompany.watchlist = watchlistCreatorClass.name
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
}

struct CreateNewWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCreator()
    }
}
