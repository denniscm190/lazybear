//
//  ComplicationViews.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 28/06/2021.
//

import SwiftUI
import ClockKit

// CIRCULAR SMALL COMPLICATIONS
// MARK: - Graphic
struct ComplicationGraphicCircular: View {
    var body: some View {
        Text("Hello")
    }
}


// MARK: - Complications Preview
struct ComplicationViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicCircularView(ComplicationGraphicCircular())
            .previewContext()
            
        }
    }
}
