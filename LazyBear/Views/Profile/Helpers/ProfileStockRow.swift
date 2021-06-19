//
//  ProfileStockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/6/21.
//

import SwiftUI

struct ProfileStockRow: View {
    var watchlistName: String
    var companies: [CompanyModel]

    @State private var showWatchlistSheet = false
    @State private var willRenameWatchlist = false
    @State private var showRenameWatchlistSheet = false
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(watchlistName)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding([.top, .horizontal])
                    
                    Text("Real-time quotes")
                        .font(.caption)
                        .opacity(0.5)
                        .padding(.horizontal)
                }
                
                Spacer()
                Button("See all", action: { showWatchlistSheet = true })
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(companies, id: \.self) { company in
                       StockItem(company: company)
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
        .sheet(isPresented: $showWatchlistSheet, onDismiss: didDismissWatchlistSheet) {
            WatchlistSheet(listName: watchlistName, apiCompanies: companies, willRenameWatchlist: $willRenameWatchlist)
                .environment(\.managedObjectContext, self.moc)
        }
        .sheet(isPresented: $showRenameWatchlistSheet) {
            RenameListSheet(oldWatchlistName: watchlistName)
                .environment(\.managedObjectContext, self.moc)
        }
    }
    
    /*
     If user wants to rename watchlist -> when WatchlistSheet is dismissed, show RenameListSheet
     */
    private func didDismissWatchlistSheet() {
        if willRenameWatchlist {
            showRenameWatchlistSheet = true
        }
    }
}

struct ProfileStockRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStockRow(
            watchlistName: "mostactive",
            companies: [CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3])]
        )
    }
}
