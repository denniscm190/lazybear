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
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if search.showSearchList {
                    CompanyList(searchResult: search.data)
                } else {
                    VStack(alignment: .center) {
                        Image("suitBear")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Are you looking for something?")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        
                        Text("Use the search bar to find your favourite company. Type the stock symbol or name, I'll find it")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarSearch($searchedText)
            .onChange(of: searchedText, perform: { searchedText in
                encodeAndRequest(searchedText)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    /*
     1) Check if searchedText is empty
     2) Encode white spaces
     3) Make API request
     */
    private func encodeAndRequest(_ searchedText: String) {
        if !searchedText.isEmpty {
            let encodedSearchedText = searchedText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            search.request("https://api.lazybear.app/search/text=\(encodedSearchedText ?? "")")
        } else {
            search.showSearchList = false
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
