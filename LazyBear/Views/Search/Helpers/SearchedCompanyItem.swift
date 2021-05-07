//
//  SearchedCompanyItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct SearchedCompanyItem: View {
    var company: SearchResponse
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompany: FetchedResults<WatchlistCompany>
    
    @State private var showingActionSheet = false
    
    var body: some View {
        let watchlistSymbols = watchlistCompany.map { $0.symbol }
        HStack {
            Button(action: { self.showingActionSheet = true }) {
                if watchlistSymbols.contains(company.symbol!) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .imageScale(.large)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                        .imageScale(.large)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading) {
                Text(company.symbol!.uppercased())
                    .fontWeight(.semibold)

                Text(company.securityName!.capitalized)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(company.currency!)
                    .fontWeight(.semibold)
                
                Text(company.region!)
            }
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Add to watchlist"), message: Text("Select"), buttons: generateButtons())
        }
    }
    
    // Get watchlist names -> generate buttons
    private func generateButtons() -> [ActionSheet.Button] {
        var actionButtons = [ActionSheet.Button]()
        let watchlists = Set(watchlistCompany.map { $0.watchlist })
        
        for watchlistName in watchlists {
            actionButtons.append(
                .default(Text(watchlistName)) {
                    addCompany(company.symbol!, company.securityName!, watchlistName)
                }
            )
        }
        
        actionButtons.append(.cancel())
        
        return actionButtons
    }
    
    // Add to watchlist
    private func addCompany(_ symbol: String, _ name: String, _ watchlist: String) {
        let watchlistCompany = WatchlistCompany(context: moc)
        watchlistCompany.symbol = symbol
        watchlistCompany.name = name
        watchlistCompany.watchlist = watchlist
        do {
            try moc.save()
            print("Company saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CompanyRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchedCompanyItem(company: SearchResponse(currency: "USD", region: "US", securityName: "apple inc", symbol: "aapl"))
    }
}
