//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct Search: View {
    @State var searchedCompany = String()
    @EnvironmentObject var apiAccess: ApiAccess  // Env apis info
    let persistenceController = PersistenceController.shared // Core Data
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchedText: $searchedCompany)
                List {
                    if searchedCompany.count > 2 {
                    ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) }), id: \.symbol) { company in
                            CompanyRow(company: company)
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                .environmentObject(apiAccess)  // Api info (url and token)
                        }
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
