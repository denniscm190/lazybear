//
//  WatchlistRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

struct WatchlistRow: View {
    var watchlistData: WatchlistData
    @Environment(\.editMode) var editMode  // EditButton list
    @EnvironmentObject var apiManager: ApiManager
    
    var body: some View {
        let name = watchlistData.name ?? ""
        let symbol = watchlistData.symbol ?? ""
        NavigationLink(destination: Company(name: name, symbol: symbol)) {
            HStack {
                WebImage(url: URL(string: endpoint(symbol: symbol)))
                    .resizable()
                    .placeholder { LogoPlaceholder() }  // If there is no logo
                    .indicator(.activity)
                    .modifier(LogoModifier())
                
                VStack(alignment: .leading) {
                    Text(symbol.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(name.capitalized)
                        .font(.subheadline)
                }
                
                Spacer()
                if self.editMode?.wrappedValue.isEditing ?? true { } else { // If EditButton() is not clicked -> show prices
                    Price(symbol: symbol, showHorizontal: false)
                }
            }
            .padding([.top, .bottom], 6)
        }
    }
    
    private func endpoint(symbol: String) -> String {
        let url = apiManager.results[0].url
        let path = "/iex/api/logos/\(symbol).png"
        let endpoint = url! + path
        
        return endpoint
    }
}


struct WatchlistRow_Previews: PreviewProvider {
    // Avoid preview crashing
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let watchlistData = WatchlistData(context: moc)
        watchlistData.name = "apple inc"
        watchlistData.symbol = "aapl"
        return WatchlistRow(watchlistData: watchlistData)
    }
}

