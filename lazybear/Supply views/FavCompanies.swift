//
//  FavCompanies.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI

struct FavCompanies: View {
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    @FetchRequest(entity: FavCompany.entity(), sortDescriptors: [])  // Core data
    var favCompanies: FetchedResults<FavCompany>  // Fetch core data
    
    var body: some View {
        List {
            ForEach(favCompanies) { favCompany in
                HStack {
                    NavigationLink(destination: Company(cik: Int(favCompany.cik), symbol: favCompany.symbol, name: favCompany.name)
                                    .navigationBarTitle(favCompany.name.capitalized)
                    ) {
                        Text(favCompany.name.capitalized)
                    }
                }.padding()
            }
            // Delete from persistent storage
            .onDelete { indexSet in
                for index in indexSet {
                    viewContext.delete(favCompanies[index])
                }
                do {
                    try viewContext.save()
                    print("Company deleted")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
        
    }

struct FavCompanies_Previews: PreviewProvider {
    static var previews: some View {
        FavCompanies()
    }
}
