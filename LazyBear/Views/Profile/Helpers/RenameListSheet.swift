//
//  RenameListSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/6/21.
//

import SwiftUI
import Introspect

struct RenameListSheet: View {
    var oldWatchlistName: String
    @State private var newWatchlistName = String()
    
    @Environment(\.presentationMode) private var renameListSheetPresentationMode
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    var body: some View {
        NavigationView {
            Form {
                let header = "Need ideas? Try my portfolio, or banks"
                Section(header: Text(header)) {
                    TextField("Enter a name", text: $newWatchlistName)
                        .introspectTextField { textField in
                            textField.becomeFirstResponder()
                        }
                }
            }
            .navigationTitle("Rename your watchlist")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { renameListSheetPresentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !newWatchlistName.isEmpty {
                        Button("Done", action: { renameWatchlist() })
                    }
                }
            }
        }
    }
    
    /*
     Rename watchlistName variable from each Core Data (WatchlistCompany) object
     */
    private func renameWatchlist() {
        for watchlistCompany in watchlistCompanies {
            watchlistCompany.watchlistName = newWatchlistName
        }
        
        do {
            try moc.save()
            renameListSheetPresentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct RenameListSheet_Previews: PreviewProvider {
    static var previews: some View {
        RenameListSheet(oldWatchlistName: "Old name")
    }
}
