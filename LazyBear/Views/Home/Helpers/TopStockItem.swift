//
//  TopStockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(colorScheme == .dark ? Color(.secondarySystemBackground) : Color.white)
                .aspectRatio(0.8, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.2), radius: 5)
                .overlay(
                    VStack(alignment: .leading) {
                        Group {
                            Text("Symbol".uppercased())
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("Company name".capitalized)
                                .fontWeight(.semibold)
                                .opacity(0.6)
                            
                            Text("$120.20")
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("+\(1.22, specifier: "%.2f")%")
                                .fontWeight(.semibold)
                                
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                         
                        
                        LineView()
                            .padding(.vertical)
                            .clipped()
                            
                            
                    }
                )
    }
}

struct TopStockItem_Previews: PreviewProvider {
    static var previews: some View {
        TopStockItem()

    }
}
