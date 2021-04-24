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
    
    @Environment(\.presentationMode) private var extensiveListPresent
    @State private var isEditMode: EditMode = .inactive
    @State private var showRenameAction = false
    @State private var showDeleteAlert = false
    
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
                            .onDelete(perform: addOnDelete ? removeCompany: nil)
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
                RenameSheet(showAction: $showRenameAction)
                    .offset(y: showRenameAction ? 0: 700)
                    .animation(.easeInOut)
            }
            // Show delete list alert
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Are you sure you want to delete this list?"),
                    message: Text("This action can't be undo"),
                    primaryButton: .destructive(Text("Delete")) {
                        print("Deleting...")
                    },
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
                        Button(action: { extensiveListPresent.wrappedValue.dismiss() }) {
                            Image(systemName: "multiply")
                                .imageScale(.large)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if addOnDelete {
                        Menu {
                            Section {
                                Button(action: { self.showRenameAction = true }) {
                                    Label("Rename list", systemImage: "square.and.pencil")
                                }

                                Button(action: { print("Add company") }) {
                                    Label("Add company", systemImage: "plus")
                                }
                            }

                            Section(header: Text("Secondary actions")) {
                                Button(action: { self.showDeleteAlert = true }) {
                                    Label("Delete list", systemImage: "trash")
                                }
                            }
                        }
                        label: {
                            Label("Options", systemImage: "ellipsis.circle")
                                .imageScale(.large)
                        }
                    }
                }
            }
            .environment(\.editMode, self.$isEditMode)  // Always after Toolbar
        }
    }
    private func removeCompany(at offsets: IndexSet) {
        print("Hello")
    }
}

struct ExtensiveList_Previews: PreviewProvider {
    static var previews: some View {
        ExtensiveList(listName: "List name", addOnDelete: false)
    }
}
