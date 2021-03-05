//
//  SideColor.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct SideColor: View {
    var rowNumber: Int
    
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        let theme = userSettings.first?.theme?.lowercased() ?? "default"
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color("\(theme)Row\(rowNumber)"))
            .frame(width: 5)
    }
}

struct SideColor_Previews: PreviewProvider {
    static var previews: some View {
        SideColor(rowNumber: 2)
    }
}
