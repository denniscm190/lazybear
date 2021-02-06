//
//  CompanyRown.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

struct CompanyRow: View {
    var company: CompanyModel
    @State var showingCompany = false
    
    @EnvironmentObject var apiAccess: ApiAccess  // Env apis info
    let persistenceController = PersistenceController.shared // Core Data
    
    var body: some View {
        Button(action: { self.showingCompany.toggle() }) {
            VStack(alignment: .leading) {
                Text(company.symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(company.name.capitalized)
                    .font(.subheadline)
            }
        }
        .fullScreenCover(isPresented: $showingCompany) {
            Company(name: company.name, symbol: company.symbol)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(apiAccess)  // Api info (url and token)
        }
    }
}

struct CompanyRown_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(company: companiesData[0])
    }
}
