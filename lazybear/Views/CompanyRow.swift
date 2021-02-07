//
//  CompanyRown.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

struct CompanyRow: View {
    var company: CompanyModel?
    var history: RecentSearch?
    @State var showingCompany = false
    
    var body: some View {
        let name = company?.name ?? history?.name ?? ""
        let symbol = company?.symbol ?? history?.symbol ?? ""
        
        NavigationLink(destination: Company(name: name, symbol: symbol)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(symbol.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(name.capitalized)
                        .font(.subheadline)
                }
                
                if history != nil {
                    Spacer()
                    let (day, month) = formatDate()
                    Text("\(day) \(month)")
                        .font(.caption)
                }
            }
        }
    }
    
    private func formatDate() -> (String, String) {
        let date = history?.date ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month], from: date)
        
        let day = components.day ?? 0  // Get day number
        let month = components.month ?? 0  // Get month number
        let monthString = calendar.monthSymbols[month]  // Get month with letters
        
        return (String(day), monthString)
    }
}

struct CompanyRown_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(company: companiesData[0])
    }
}
