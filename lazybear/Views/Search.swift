//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct Search: View {
    @State var searchedCompany = String()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchedText: $searchedCompany)
                List {
                    if searchedCompany.count > 2 {
                        CompanyList(searchedCompany: searchedCompany)
                    } else {
                        HistoryList()
                    }
                }
                .id(UUID())  // Increase speed in search the list
                .navigationBarTitle("Search", displayMode: .inline)
            }
        } .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
