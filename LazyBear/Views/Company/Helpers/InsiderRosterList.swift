//
//  InsiderRosterList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/6/21.
//

import SwiftUI

struct InsiderRosterList: View {
    var insiderRoster: [InsiderRosterModel]
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                let totalPositions =  insiderRoster.map { $0.position ?? 0 }.reduce(0, +)  /// Get total shares owned by top 10 insiders
                ForEach(insiderRoster, id: \.self) { insider in
                    let percentageOfWidth = Double(insider.position ?? 0) / Double(totalPositions)   /// Compute percentage of ownership for each insider
                    InsiderRosterRow(insider: insider, percentageOfWidth: CGFloat(percentageOfWidth))
                    Divider()
                }
            }
            .padding()
        }
    }
}

struct InsiderRosterList_Previews: PreviewProvider {
    static var previews: some View {
        InsiderRosterList(
            insiderRoster:
                [
                    InsiderRosterModel(
                        entityName: "Tim Cook",
                        position: 12345,
                        reportDate: 12345
                    )
                ]
        )
    }
}
