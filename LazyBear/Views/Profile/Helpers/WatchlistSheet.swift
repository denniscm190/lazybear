//
//  WatchlistSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/6/21.
//

import SwiftUI

struct WatchlistSheet: View {
    var listName: String
    var companies: [CompanyModel]
    
    @Environment(\.presentationMode) private var watchlistSheetPresentation
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [NSSortDescriptor(key:"symbol", ascending:true)])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    /*
     NSSortDescriptor and .sorted(by: {} in ForEach must coincide. If not .onDelete is not working well.
     */
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(companies.sorted(by: { $0.companyName < $1.companyName }), id: \.self) { company in
                        StockSheetRow(company: company)
                    }
                    .onDelete(perform: deleteCompany)
                }
            }
            .navigationTitle(listName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {watchlistSheetPresentation.wrappedValue.dismiss()}) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
    
    /*
     Delete company from watchlist
     */
    private func deleteCompany(at offsets: IndexSet) {
        print(watchlistCompanies)
        for index in offsets {
            print(index)
            let company = watchlistCompanies[index]
            moc.delete(company)
        }
        do {
            try moc.save()
            print("Company deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct WatchlistSheet_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistSheet(
            listName: "Most active",
            companies: [CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3])]
        )
    }
}
