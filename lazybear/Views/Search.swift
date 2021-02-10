//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

/*
 If the search is not tapped, which means the user is not searching => show HistoryList().
 If it's tapped and the text searched is bigger that 2 letters => show results
 */

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
