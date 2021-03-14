//
//  InsiderSummary.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct InsiderSummary: View {
    var symbol: String
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "star.fill")
                    .renderingMode(.original)
                    .imageScale(.large)
                
                Text("Top insiders")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
        }
        .padding()
    }
}

struct InsiderSummary_Previews: PreviewProvider {
    static var previews: some View {
        InsiderSummary(symbol: "aapl")
    }
}
