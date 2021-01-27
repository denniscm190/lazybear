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
    @ObservedObject var companyView = CompanyView()
    @Environment(\.editMode) var editMode  // EditButton list
    var company: WatchlistCompany
    var url: String
    
    var body: some View {
        Button(action: { companyView.isShowing.toggle() }) {
            HStack {
                let path = LogoApi.URL.company(symbol: company.symbol!).path
                let endpoint = url + path
                WebImage(url: URL(string: endpoint))
                    .resizable()
                    .placeholder { LogoPlaceholder(placeholder: company.symbol!) }  // If there is no logo
                    .indicator(.activity)
                    .modifier(LogoModifier())
                
                VStack(alignment: .leading) {
                    Text(company.symbol!.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(company.name!.capitalized)
                        .font(.caption)
                }
                
                Spacer()
                if self.editMode?.wrappedValue.isEditing ?? true { } else { // If is not editing -> show prices
                    Price()
                }
            }
        }
    }
}

struct WatchlistRow_Previews: PreviewProvider {
    // Avoid preview crashing
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let watchlistCompany = WatchlistCompany(context: moc)
        watchlistCompany.name = "apple inc"
        watchlistCompany.symbol = "aapl"
        return WatchlistRow(company: watchlistCompany, url: "")
    }
}
