//
//  ComplicationViews.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 28/06/2021.
//

import SwiftUI
import ClockKit

// MARK: - Graphic Rectangular Full View Chart
struct ComplicationGraphicRectangularFullViewChart: View {
    @State var home: HomeResponse
    
    var body: some View {
        Text("Hello")
    }
}


// MARK: - Complications Preview
struct ComplicationViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicRectangularFullView(ComplicationGraphicRectangularFullViewChart())
                .previewContext()
        }
    }
}
