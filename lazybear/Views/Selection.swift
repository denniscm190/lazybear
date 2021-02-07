//
//  DateSelection.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct Selection: View {
    var items: [String]
    @Binding var selected: Int
    
    var body: some View {
        Picker(selection: $selected, label: Text("Please choose a period")) {
            ForEach(0 ..< items.count) {
                Text(self.items[$0])
            }
        }
         .pickerStyle(SegmentedPickerStyle())
    }
}

struct Selection_Previews: PreviewProvider {
    static var previews: some View {
        Selection(items: ["1", "2", "3", "4", "5", "6", "7"], selected: .constant(2))
    }
}
