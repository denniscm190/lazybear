//
//  FavCompanies.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI
/*
struct FavCompanyList: View {
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    @FetchRequest(entity: FavCompany.entity(), sortDescriptors: [])  // Core data
    var favCompanies: FetchedResults<FavCompany>  // Fetch core data
    
    var body: some View {
        List {
            ForEach(favCompanies) { company in
                let index = favCompanies.firstIndex(of: company)
                FavCompanyRow(favCompany: company, index: index!)
            }
            // Delete from persistent storage
            .onDelete { indexSet in delete(indexSet: indexSet) }
        }
    }
    
    func delete(indexSet: IndexSet) {
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

struct FavCompanies_Previews: PreviewProvider {
    static var previews: some View {
        FavCompanyList()
    }
}
*/
