//
//  TradingDatesItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct TradingDatesItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 100)
            .overlay(
                HStack {
                    Rectangle()
                        .frame(width: 15)
                        .foregroundColor(Color("default"))
                        
                    VStack {
                        Text("April")
                            .fontWeight(.semibold)
                        
                        Text("20")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("default"))
                    }
                    
                    Spacer()
                    VStack {
                        Text("US Markets open in regular hours")
                            .fontWeight(.semibold)
                        
                        Text("Random funny phrase")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .opacity(0.6)
                    }
                    
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
            )
    }
}

struct TradingDatesItem_Previews: PreviewProvider {
    static var previews: some View {
        TradingDatesItem()
    }
}
