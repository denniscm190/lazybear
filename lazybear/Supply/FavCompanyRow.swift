//
//  FavCompanyRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/1/21.
//

import SwiftUI

struct FavCompanyRow: View {
    var company: CompanyData
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FavCompany.entity(), sortDescriptors: [])
    var favCompanies: FetchedResults<FavCompany>
    
    var body: some View {
        let names = favCompanies.map { $0.name }
        HStack {
            if names.contains(company.name) {
                Button(action: { deleteFavourite(symbol: company.symbol, name: company.name) }) {
                    Image(systemName: "minus.circle.fill")
                        .iconModifier()
                }
            }
            else {
                Button(action: { addFavourite(symbol: company.symbol, name: company.name) }) {
                    Image(systemName: "plus.circle.fill")
                        .iconModifier()
                }
            }
            Text(company.name.capitalized)
        }
    }
    
    func addFavourite(symbol: String, name: String) {
        let favCompany = FavCompany(context: viewContext)
        favCompany.symbol = symbol
        favCompany.name = name
        do {
            try viewContext.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavourite(symbol: String, name: String) {
        
    }
}
extension Image {
    func iconModifier() -> some View {
        self
            .renderingMode(.original)
            .resizable()
            .frame(width: 25, height: 25)
    }
}

struct FavCompanyRow_Previews: PreviewProvider {
    static var previews: some View {
        FavCompanyRow(company: companiesData[0])
    }
}
