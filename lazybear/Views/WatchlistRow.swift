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
    @EnvironmentObject var apiAccess: ApiAccess
    @ObservedObject var companyView = CompanyView()
    @Environment(\.editMode) var editMode  // EditButton list
    var company: WatchlistCompany
    
    var body: some View {
        Button(action: { companyView.isShowing.toggle() }) {
            HStack {
                let url = apiAccess.results[0].url
                let path = "/iex/api/logos/\(company.symbol!).png"
                let endpoint = url! + path
                WebImage(url: URL(string: endpoint))
                    .resizable()
                    .placeholder { LogoPlaceholder() }  // If there is no logo
                    .indicator(.activity)
                    .modifier(LogoModifier())
                
                VStack(alignment: .leading) {
                    Text(company.symbol ?? "".uppercased())
                        .fontWeight(.semibold)
                    
                    Text(company.name ?? "".capitalized)
                        .font(.subheadline)
                }
                
                Spacer()
                if self.editMode?.wrappedValue.isEditing ?? true { } else { // If EditButton() is not clicked -> show prices
                    Price(symbol: company.symbol ?? "", showVertical: false)
                }
            }
        }
        .fullScreenCover(isPresented: $companyView.isShowing) {
            Company(name: company.name ?? "", symbol: company.symbol ?? "")
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
        return WatchlistRow(company: watchlistCompany)
    }
}
