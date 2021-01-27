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
    var company: WatchlistCompany
    var url: String
    
    var body: some View {
        Button(action: { companyView.isShowing.toggle() }) {
            HStack {
                let path = GoogleApi.URL.company(symbol: company.symbol!).path
                WebImage(url: URL(string: url + path))
                    .resizable()
                    .placeholder { Rectangle().foregroundColor(.gray) }
                    .indicator(.activity) // Activity Indicator
                    .modifier(LogoModifier())
                
                VStack(alignment: .leading) {
                    Text(company.symbol!.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(company.name!.capitalized)
                        .font(.caption)
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
