//
//  ListAvatarHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

struct ListAvatarHelper: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach((1..<8), id: \.self) { index in
                    Image("randomGirl\(index)")
                }
            }
        }
    }
}

struct ListAvatarHelper_Previews: PreviewProvider {
    static var previews: some View {
        ListAvatarHelper()
    }
}
