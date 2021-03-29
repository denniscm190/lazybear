//
//  TopStockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockRow: View {
    var keyTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(keyTitle)
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach((1..<10)) { _ in
                        TopStockItem()
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
    }
}

struct TopStockRow_Previews: PreviewProvider {
    static var previews: some View {
        TopStockRow(keyTitle: "Sample title")
    }
}
