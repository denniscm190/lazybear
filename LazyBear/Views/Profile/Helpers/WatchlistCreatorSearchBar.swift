//
//  WatchlistCreatorSearchBar.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/5/21.
//

import SwiftUI
import Introspect

struct WatchlistCreatorSearchBar: View {
    @Binding var searchedCompany: String
    
    var body: some View {
        TextField("", text: $searchedCompany)
            .introspectTextField { textField in
                textField.becomeFirstResponder()
            }
            .padding(10)
            .padding(.leading, 40)
            .overlay(
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .opacity(0.4)
                    .padding(.horizontal)
                ,alignment: .leading
            )
            .background(
                Color(.secondarySystemBackground)
                    .cornerRadius(10)
            )
            .padding()
        
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCreatorSearchBar(searchedCompany: .constant(""))
    }
}
