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
    
    // <--------- Core Data --------->
    let persistenceController = PersistenceController.shared // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: RecentSearch.entity(), sortDescriptors: [])
    var searches: FetchedResults<RecentSearch>
    // <--------- Core Data --------->
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchedText: $searchedCompany)
                // Searched companies
                List {
                    if searchedCompany.count > 2 {
                    ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) }), id: \.symbol) { company in
                            CompanyRow(company: company)
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                .environmentObject(apiAccess)  // Api info (url and token)
                        }
                    } else {
                        // Historial
                        if searches.count > 0 {
                            Section(header: Text("History"),
                                    footer: Button(action: { delete() }) { Text("Clear history").foregroundColor(.blue)}
                            ) {
                                ForEach(searches) { search in
                                    CompanyRow(history: search)
                                }
                            }
                        }
                    }
                }
                .id(UUID())  // Increase speed in search the list
                .navigationBarTitle("Search", displayMode: .inline)
            }
        } .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func delete() {
        for value in searches {
            viewContext.delete(value)
        }
        do {
            try viewContext.save()
            print("History deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
