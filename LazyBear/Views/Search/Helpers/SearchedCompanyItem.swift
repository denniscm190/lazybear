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
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    @State private var showingWatchlistSelector = false
    
    var body: some View {
        HStack {
            Button(action: { self.showingWatchlistSelector = true }) {
                let watchlistSymbols = watchlistCompanies.map { $0.symbol }
                if watchlistSymbols.contains(company.symbol!) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                        .imageScale(.large)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(Color.yellow)
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
        .actionSheet(isPresented: $showingWatchlistSelector) {
            ActionSheet(title: Text("Add to watchlist"), message: Text("Select"), buttons: generateButtons())
        }
    }
    
    /*
     Generate buttons for each watchlist to let the user selects to which watchlist
     he wants to add the company
     */
    private func generateButtons() -> [ActionSheet.Button] {
        var actionButtons = [ActionSheet.Button]()
        let watchlists = Set(watchlistCompanies.map { $0.watchlistName })
        
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
    
    /*
     When the user taps the watchlist -> save the company to CoreData
     */
    private func addCompany(_ symbol: String, _ name: String, _ watchlistName: String) {
        let watchlistCompany = WatchlistCompany(context: moc)
        watchlistCompany.symbol = symbol
        watchlistCompany.name = name
        watchlistCompany.watchlistName = watchlistName
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
