//
//  CompanyRown.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

/*
 Reuse this struct for two types of data, CompanyModel and HistoryData.
 If HistoryData is passed => show the base row + date added to the list.
 Else show base row
 */

struct CompanyRow: View {
    var companyModel: CompanyModel? //Optional
    var historyData: HistoryData? // Optional
    @State var showingCompany = false
    
    var body: some View {
        let name = companyModel?.name ?? historyData?.name ?? ""
        let symbol = companyModel?.symbol ?? historyData?.symbol ?? ""
        
        NavigationLink(destination: Company(name: name, symbol: symbol)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(symbol.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(name.capitalized)
                        .font(.subheadline)
                }
                
                if historyData != nil {
                    Spacer()
                    let (day, month) = formatDate()
                    Text("\(day) \(month)")
                        .font(.caption)
                }
            }
        }
    }
    
    // From long date get only day and month in letters
    private func formatDate() -> (String, String) {
        let date = historyData?.date ?? Date()
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
        CompanyRow(companyModel: companiesData[0])
    }
}
