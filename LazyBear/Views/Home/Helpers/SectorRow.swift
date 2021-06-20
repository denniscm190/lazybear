//
//  SectorRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct SectorRow: View {
    var sectorPerformance: [SectorPerformanceModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Performance by sector")
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            Text("Real-time data")
                .font(.caption)
                .opacity(0.5)
                .padding([.horizontal, .bottom])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(sectorPerformance, id: \.self) { sector in
                        SectorItem(sector: sector)
                    }
                }
                .padding()
            }
            .frame(height: 170)
        }
        .padding(.bottom)
    }
}

struct SectorRow_Previews: PreviewProvider {
    static var previews: some View {
        SectorRow(sectorPerformance: [SectorPerformanceModel(name: "Technology", performance: 0.04)])
    }
}
