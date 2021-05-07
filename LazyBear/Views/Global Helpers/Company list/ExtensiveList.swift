//
//  ExtensiveList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/4/21.
//

import SwiftUI

struct ExtensiveList: View {
    var listName: String
    var list: [String: QuoteModel]?
    var intradayPrices: [String: [IntradayPriceModel]]?
    var latestCurrencies: [String: CurrencyModel]?
    var addOnDelete: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompany: FetchedResults<WatchlistCompany>
    
    @State private var isEditMode: EditMode = .inactive
    @State private var showRenameAction = false
    @State private var showDeleteAlert = false
    @State private var showSearchView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if let list = list {
                        List {
                            ForEach(Array(list.keys.sorted()), id: \.self) { companySymbol in
                                    StockItem(symbol: companySymbol,
                                              company: list[companySymbol]!,
                                              intradayPrices: intradayPrices?[companySymbol],
                                              orientation: .horizontal,
                                              hidePriceView: self.isEditMode == .active  // Hide on EditMode
                                    )
                                
                            }
                            .onDelete(perform: addOnDelete ? deleteCompany: nil)
                        }
                    }
                    
                    if let latestCurrencies = latestCurrencies {
                        List(Array(latestCurrencies.keys.sorted()), id: \.self) { currencySymbol in
                            CurrencyListItem(currencySymbol: currencySymbol, currency: latestCurrencies[currencySymbol]!)
                            
                        }
                    }
                }
                
                // Blur background
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(showRenameAction ? 0.2: 0)
                    .animation(.easeInOut)
                    .onTapGesture { showRenameAction = false }
                
                // Show rename Action Sheet
                TextfieldAlert(listName: listName, showRenameAction: $showRenameAction, presentationMode: presentationMode)
                    .offset(y: showRenameAction ? 0: 700)
                    .animation(.easeInOut)
            }
            // Show delete list alert
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Are you sure you want to delete this list?"),
                    message: Text("This action can't be undo"),
                    primaryButton: .destructive(Text("Delete")) { deleteList() },
                    secondaryButton: .cancel()
                )
            }
            .navigationTitle(listName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    if addOnDelete {
                        EditButton()
                    } else {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "multiply")
                                .imageScale(.large)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if addOnDelete {
                        ToolbarMenu(showRenameAction: $showRenameAction, showDeleteAlert: $showDeleteAlert)
                    }
                }
            }
            .environment(\.editMode, self.$isEditMode)  // Always after Toolbar
        }
    }
    
    // Delete company from watchlist
    private func deleteCompany(at offsets: IndexSet) {
        for index in offsets {
            let company = watchlistCompany[index]
            moc.delete(company)
        }
        do {
            try moc.save()
            print("Company deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Remove entire watchlist
    private func deleteList() {
        let selectedWatchlist = watchlistCompany.filter({ $0.watchlist == listName })
        for company in selectedWatchlist {
            moc.delete(company)
        }
        do {
            try moc.save()
            print("List deleted")
            presentationMode.wrappedValue.dismiss()  // Dismiss view
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExtensiveList_Previews: PreviewProvider {
    static var previews: some View {
        ExtensiveList(listName: "List name", addOnDelete: false)
    }
}
