//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var searchedCompany = String()
    @State public var showingSearch: Bool = false
    let persistenceController = PersistenceController.shared

    var body: some View {
        VStack(alignment: .leading) {
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            SearchBar(searchedText: $searchedCompany, showingSearch: $showingSearch)
            
            if !showingSearch {
                HeaderWatchlist()
                //FavCompanyList()
                    //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                
            } else {
                if searchedCompany.count > 2 {
                    CompanyList(searchedCompany: $searchedCompany)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
