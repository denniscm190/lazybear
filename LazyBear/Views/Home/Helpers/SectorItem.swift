//
//  SectorItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct SectorItem: View {
    @Environment(\.colorScheme) var colorScheme
    var sector: SectorPerformanceModel
    
    var body: some View {
        VStack {
            Image(sector.name)
                .resizable()
                .background(Color.black)
                .opacity(0.7)
                .clipShape(Circle())
                .overlay(Circle().stroke(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white, lineWidth: 4))
                .shadow(color: Color.black.opacity(0.2), radius: 5)
                .overlay(
                    VStack {
                        Text("\(sector.performance*100, specifier: "%.2f")%")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(sector.performance < 0 ? .red: .green)
                    }
                )
            
            Text(sector.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .frame(width: 170, height: 170)
    }
}

struct SectorItem_Previews: PreviewProvider {
    static var previews: some View {
        SectorItem(sector: SectorPerformanceModel(name: "Technology", performance: 0.04))
    }
}
