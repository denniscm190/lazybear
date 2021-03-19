//
//  IndicatorPoint.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/3/21.
//

import SwiftUI

struct IndicatorPoint: View {
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        let colour = Color("\(userSettings.first?.theme?.lowercased() ?? "default")Accent")
        Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(colour)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
