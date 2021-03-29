//
//  SectorRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct SectorRow: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Performance by sector")
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach((1..<10)) { _ in
                        SectorItem()
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
        SectorRow()
    }
}
