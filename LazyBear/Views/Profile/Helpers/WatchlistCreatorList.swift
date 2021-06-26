//
//  WatchlistCreatorList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/5/21.
//

import SwiftUI
import Alamofire

struct WatchlistCreatorList: View {
    @ObservedObject var watchlistCreatorClass: WatchlistCreatorClass
    
    @State private var searchedCompany = String()
    @State private var companies = [SearchResponse]()
    
    @Environment(\.presentationMode) private var watchlistCreatorListPresentation
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        NavigationView {
            VStack {
                WatchlistCreatorSearchBar(searchedCompany: $searchedCompany)
                
                List(companies, id: \.self) { company in
                    WatchlistCreatorRow(company: company, watchlistCreatorListPresentation: watchlistCreatorListPresentation, watchlistCreatorClass: watchlistCreatorClass)
                        .environment(\.managedObjectContext, self.moc)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: searchedCompany, perform: { searchedCompany in
                encodeAndRequest(searchedCompany)
            })
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: { watchlistCreatorListPresentation.wrappedValue.dismiss() })
                }
            }
        }
    }
    
    /*
     Get companies from the API that matches the searched text
     */
    private func request(_ url: String) {
        AF.request(url).responseDecodable(of: [SearchResponse].self) { response in
            if let value = response.value {
                self.companies = value
            }
        }
    }
    
    /*
     1) Check if searchedCompany is empty
     2) Encode white spaces
     3) Request API
     */
    private func encodeAndRequest(_ searchedCompany: String) {
        if !searchedCompany.isEmpty {
            let encodedSearchedCompany = searchedCompany.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            request("https://api.lazybear.app/search/text=\(encodedSearchedCompany ?? "")")
        }
    }
}

struct SearchCompanies_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCreatorList(watchlistCreatorClass: WatchlistCreatorClass())
    }
}
