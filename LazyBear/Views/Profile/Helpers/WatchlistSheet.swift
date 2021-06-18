//
//  WatchlistSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/6/21.
//

import SwiftUI

struct WatchlistSheet: View {
    var listName: String
    var apiCompanies: [CompanyModel]
    
    @Environment(\.presentationMode) private var watchlistSheetPresentationMode
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    @State private var showDeleteListAlert = false
    @State private var showRenameListSheet = false 
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(watchlistCompanies.filter { $0.watchlistName == listName }, id: \.self) { watchlistCompany in
                        let apiCompany = apiCompanies.first(where: { $0.symbol == watchlistCompany.symbol })
                        WatchlistSheetRow(apiCompany: apiCompany!, watchlistCompany: watchlistCompany)
                    }
                    .onDelete(perform: deleteCompany)
                }
            }
            .navigationTitle(listName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {watchlistSheetPresentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "multiply")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarMenu(showRenameListSheet: $showRenameListSheet, showDeleteListAlert: $showDeleteListAlert)
                }
            }
        }
        .sheet(isPresented: $showRenameListSheet) {
            RenameListSheet(oldWatchlistName: listName)
                .environment(\.managedObjectContext, self.moc)
        }
        .alert(isPresented: $showDeleteListAlert) {  /// Show delete list alert
            Alert(
                title: Text("Are you sure you want to delete this list?"),
                message: Text("This action can't be undo"),
                primaryButton: .destructive(Text("Delete")) { deleteList() },
                secondaryButton: .cancel()
            )
        }
    }
    
    /*
     Delete company from watchlist.
     */
    private func deleteCompany(at offsets: IndexSet) {
        let watchlistCompaniesFiltered = watchlistCompanies.filter { $0.watchlistName == listName }
        for index in offsets {
            let company = watchlistCompaniesFiltered[index]
            moc.delete(company)
        }
        do {
            try moc.save()
            print("Company deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /*
     Remove entire list if it's not the last one.
     */
    private func deleteList() {
        let watchlistCompaniesFiltered = watchlistCompanies.filter { $0.watchlistName == listName }
        for company in watchlistCompaniesFiltered {
            moc.delete(company)
        }
        do {
            try moc.save()
            print("List deleted")
            watchlistSheetPresentationMode.wrappedValue.dismiss()  /// Dismiss view
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct WatchlistSheet_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistSheet(
            listName: "Most active",
            apiCompanies: [CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3])]
        )
    }
}
