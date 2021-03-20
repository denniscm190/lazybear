//
//  HorizontalBar.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/3/21.
//

import SwiftUI

struct HorizontalBar: View {
    @State var text: String
    @State var data: Int
    @State var capsulePctWidth: CGFloat  // 0.3 = 30%
    // How much large the data capsule is with respect to the placeholder capsule
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(text.capitalized)
                    .font(.headline)
                
                Spacer()
                Text("\(data) shares")
            }
            ZStack {
                GeometryReader { geo in
                    Group {
                        Capsule()
                            .foregroundColor(Color(.systemGray))
                            .opacity(0.2)
                        
                        Capsule()
                            .foregroundColor(Color("\(userSettings.first?.theme?.lowercased() ?? "default")Accent"))
                            .frame(width: geo.size.width * capsulePctWidth)
                    }
                    .frame(height: 10)
                }
            }
        }
    }
}

struct HorizontalBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBar(text: "Dennis Concepción", data: 1000, capsulePctWidth: 0.3)
    }
}
