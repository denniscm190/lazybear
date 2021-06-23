//
//  InsiderRosterHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/6/21.
//

import SwiftUI

struct InsiderRosterHelper: View {
    var insiderRoster: [InsiderRosterModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Top Insiders")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                NavigationLink(destination: InsiderRosterList(insiderRoster: insiderRoster)
                                .navigationTitle("Top Insiders")
                ) {
                    Text("See all")
                        .accentColor(Color(.systemBlue))
                }
            }
            .padding(.bottom)
            
            let totalPositions =  insiderRoster.map { $0.position ?? 0 }.reduce(0, +)  /// Get total shares owned by top 10 insiders
            ForEach(insiderRoster.prefix(4), id: \.self) { insider in
                let percentageOfWidth = Double(insider.position ?? 0) / Double(totalPositions)   /// Compute percentage of ownership for each insider
                InsiderRosterRow(insider: insider, percentageOfWidth: CGFloat(percentageOfWidth))
                Divider()
            }
        }
        .padding()
        .background(
            CustomRectangleBox()
        )
    }
}

struct InsiderRosterHelper_Previews: PreviewProvider {
    static var previews: some View {
        InsiderRosterHelper(
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
