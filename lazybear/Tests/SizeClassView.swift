//
//  SizeClassView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/1/21.
//

import SwiftUI
import SwiftUICharts

struct SizeClassView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        VStack {
            if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                Text("iPhone Portrait")
            }
            else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
                HStack {
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.extraLarge)
                    Spacer()
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.extraLarge)
                }.padding()
                Spacer()
                HStack {
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.extraLarge)
                    Spacer()
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.extraLarge)
                }.padding()
                Spacer()
                HStack {
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.extraLarge)
                    Spacer()
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", form: ChartForm.extraLarge)
                }.padding()
            }
        }
    }
}

struct SizeClassView_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassView()
    }
}
