//
//  DateSelection.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct DateSelection: View {
    var period = ["1D", "1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State private var selectedPeriod = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedPeriod, label: Text("Please choose a period")) {
                ForEach(0 ..< period.count) {
                    Text(self.period[$0])
                }
            }
             .pickerStyle(SegmentedPickerStyle())
            
             //Text("You selected: \(period[selectedPeriod])")
        }
        .padding([.leading, .trailing])
    }
}

struct DateSelection_Previews: PreviewProvider {
    static var previews: some View {
        DateSelection()
    }
}
