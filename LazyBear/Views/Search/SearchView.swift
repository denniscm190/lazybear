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
    @State private var searchedText = String()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(searchData.companies, id: \.self) { company in
                            PopularCompanyHelper(company: company)
                        }
                    }
                }
            }
            .onAppear { searchData.request() }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarSearch($searchedText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
