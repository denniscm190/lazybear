//
//  CompanyRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyRow: View {
    var symbol: String
    var name: String
    var rowNumber: Int
    
    // Fetch user appearence settings (the last one made first)
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        HStack {
            let theme = userSettings.first?.theme?.lowercased() ?? "default"
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("\(theme)Row\(rowNumber)"))
                .frame(width: 5)
            
            VStack(alignment: .leading) {
                Text(symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(name.capitalized)
                    .lineLimit(1)
            }
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CompanyRow(symbol: "aapl", name: "apple inc", rowNumber: 2)
        }
    }
}
