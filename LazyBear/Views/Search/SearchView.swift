//
//  SearchView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI
import SwiftlySearch

struct SearchView: View {
    @ObservedObject var searchData = SearchData()
    @State private var searchedText: String = ""
    @State private var showingSearchList = false
    @EnvironmentObject var hudManager: HudManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if showingSearchList {
                    CompanyList(searchResult: searchData.searchResult)
                } else {
                    Text("Are you looking for something? 👀")
                        .fontWeight(.semibold)
                    
                    Text("Use the search bar to find a company")
                    Text(searchedText)
                }
            }
            .onDisappear { self.searchedText = ""; self.showingSearchList = false }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarSearch($searchedText)
            .onChange(of: searchedText, perform: { searchedText in
                if !searchedText.isEmpty {
                    searchData.request(searchedText)
                    self.showingSearchList = true
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { self.hudManager.showSearchHelper = true }) {
                        Image(systemName: "questionmark.circle")
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
