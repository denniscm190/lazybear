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
                Spacer()
                
                    if searchedCompany.count > 2 {
                        CompanyList(searchedCompany: searchedCompany)
                    } else {
                        HistoryList()
                    }
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
