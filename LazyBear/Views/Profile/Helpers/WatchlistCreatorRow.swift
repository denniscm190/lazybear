//
//  WatchlistCreatorRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/5/21.
//

import SwiftUI

struct WatchlistCreatorRow: View {
    var company: SearchResponse
    @Binding var watchlistCreatorListPresentation: PresentationMode
    @ObservedObject var watchlistCreatorClass: WatchlistCreatorClass
    
    var body: some View {
        Button(action: { saveCompany() }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(company.symbol!.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(company.securityName ?? "-")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .opacity(0.6)
                        .lineLimit(1)
                }
                
                Spacer()
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .foregroundColor(Color.blue)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    /*
     Save company when it's selected and dismiss view
     */
    private func saveCompany() {
        watchlistCreatorClass.companies.append(company)
        $watchlistCreatorListPresentation.wrappedValue.dismiss()
    }
}

struct WatchlistCreatorRow_Previews: PreviewProvider {
    @Environment(\.presentationMode) static var presentationMode
    
    static var previews: some View {
        WatchlistCreatorRow(company: SearchResponse(currency: "USD", exchange: nil, region: "US", securityName: "Apple Inc", symbol: "AAPL"), watchlistCreatorListPresentation: presentationMode, watchlistCreatorClass: WatchlistCreatorClass())
    }
}
