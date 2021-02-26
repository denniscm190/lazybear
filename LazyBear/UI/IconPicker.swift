//
//  IconPicker.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct IconPicker: View {
    var body: some View {
        List(icons, id:\.name) { icon in
            IconRow(icon: icon)
        }
        .listStyle(GroupedListStyle())
    }
}

struct IconPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IconPicker()
            
        }
    }
}
