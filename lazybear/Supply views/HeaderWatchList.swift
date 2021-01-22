//
//  HeaderWatchList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct HeaderWatchlist: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Text("Watchlist")
                .font(.title2)
                .fontWeight(.semibold)
                .padding([.top, .leading])
            
            Spacer()
            EditButton()
                .padding(.trailing)
        }
    }
}

struct HeaderWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWatchlist()
    }
}
