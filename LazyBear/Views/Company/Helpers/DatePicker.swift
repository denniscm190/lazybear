//
//  DatePicker.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI

struct DatePicker: View {
    var ranges: [String]
    @Binding var selectedRange: String
    
    var body: some View {
        VStack {
            Picker("Please choose a range", selection: $selectedRange) {
                ForEach(ranges, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker(ranges: ["1D", "5D", "1M", "3M", "6M", "1Y", "5Y"], selectedRange: .constant("3M"))
    }
}
