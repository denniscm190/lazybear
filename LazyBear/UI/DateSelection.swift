//
//  DateSelection.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/2/21.
//

import SwiftUI

struct DateSelection: View {
    var period: [String]
    @Binding var selectedperiod: Int
    
    var body: some View {
        Picker(selection: $selectedperiod, label: Text("Please choose a period")) {
            ForEach(0 ..< period.count) {
                Text(self.period[$0])
            }
        }
         .pickerStyle(SegmentedPickerStyle())
    }
}

struct DateSelection_Previews: PreviewProvider {
    static var previews: some View {
        DateSelection(period: ["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"], selectedperiod: .constant(0))
    }
}
