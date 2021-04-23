//
//  SearchView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI
import SwiftlySearch

struct SearchView: View {
    @ObservedObject var search = Search()
    @State private var searchedText = String()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if search.showSearchList {
                    CompanyList(searchResult: search.data)
                } else {
                    VStack(alignment: .center) {
                        Image("bearSleeping")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Are you looking for something?")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        
                        Text("Use the search bar to find your favourite company. Type the stock symbol or name, we'll find it!")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarSearch($searchedText)
            .onChange(of: searchedText, perform: { searchedText in
                if !searchedText.isEmpty {
                    // Encode string with spaces
                    let encodedSearchedText = searchedText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    search.request("https://api.lazybear.app/search/text=\(encodedSearchedText ?? "")")
                } else {
                    search.showSearchList = false
                }
            })
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
